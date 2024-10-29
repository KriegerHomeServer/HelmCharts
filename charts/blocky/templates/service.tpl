{{- define "helm-charts.blocky.service" -}}
apiVersion: v1
kind: Service
metadata:
  name: {{ .Values.service.name | default "blocky-service" }}
  namespace: {{ .Values.namespace }}
  labels:
    app: blocky
spec:
  type: {{ .Values.service.type | default "LoadBalancer" }}
  {{- if .Values.service.loadBalancerIP }}
  loadBalancerIP: {{ .Values.service.loadBalancerIP }}
  {{- end }}
  ports:
    - name: dns
      port: 53
      targetPort: 53
    - name: http
      port: 80
      targetPort: {{ .Values.deployment.httpPort | default 4000 }}
    - name: https
      port: 443
      targetPort: {{ .Values.deployment.httpPort | default 4000 }}
  selector:
    app: blocky
{{- end -}}