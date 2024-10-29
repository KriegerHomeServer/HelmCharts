{{- define "helm-charts.blocky.configmap" -}}
apiVersion: v1
kind: ConfigMap
metadata:
  name: blocky-configuration
  namespace: {{ .Values.namespace }}
data:
  config.yaml: |-
{{ toYaml .Values.config | indent 4 }}
{{- end -}}