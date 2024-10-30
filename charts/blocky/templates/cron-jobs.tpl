{{- define "helm-charts.blocky.cron-jobs" -}}
apiVersion: batch/v1
kind: CronJob
metadata:
  name: update-blocky-dns-mappings-job
  namespace: {{ .Values.namespace }}
spec:
  schedule: "*/5 * * * *"
  jobTemplate:
    spec:
      template:
        spec:
          containers:
          - name: dns-mapping-job
            image: teegank/alpine-kubectl:latest
            command:
            - /bin/bash
            - -c
            - |
              export DNS_MAPPINGS=$(kubectl get dnsmapping -n {{ .Values.namespace }} -o jsonpath='{range .items[*]}{.spec.domain}: {.spec.ip}{"\n"}{end}');
              
              if [ -z "${DNS_MAPPINGS}" ]; then
                echo "No DnsMapping resources found.";
                exit 0;
              fi

              CURRENT_CONFIG=$( kubectl get configmap/blocky-configuration -n {{ .Values.namespace }} -o jsonpath='{.data.config\.yml}' );

              NEW_CONFIG=$( echo "${CURRENT_CONFIG}" | yq '.customDNS.mapping = env(DNS_MAPPINGS)' - | sed ':a;N;$!ba;s/\n/\\n/g' );

              kubectl patch configmap/blocky-configuration -n {{ .Values.namespace }} --type='json' -p "[{ \"op\": \"replace\", \"path\": \"/data/config.yml\", \"value\": \"${NEW_CONFIG}\" }]";

              kubectl rollout restart deployment/blocky -n {{ .Values.namespace }};

          restartPolicy: Never
{{- end -}}