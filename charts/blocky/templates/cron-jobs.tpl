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
              DNS_MAPPINGS=$(kubectl get dnsmappings -A -o yaml)
              echo "${DNS_MAPPINGS}"
          restartPolicy: Never
{{- end -}}