{{- define "helm-charts.blocky.configmaps" -}}
apiVersion: v1
kind: ConfigMap
metadata:
  name: blocky-configuration
  namespace: {{ .Release.Namespace }}
data:
  config.yml: |-
{{ toYaml .Values.config | indent 4 }}
{{- end -}}