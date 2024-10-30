{{- define "helm-charts.blocky.configmaps" -}}
apiVersion: v1
kind: ConfigMap
metadata:
  name: blocky-configuration
  namespace: {{ .Values.namespace }}
data:
  config.yml: |-
{{ toYaml .Values.config | indent 4 }}
{{- end -}}