{{- define "helm-charts.blocky.role-bindings" -}}
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: blocky-cronjob-sa-configmap-access-binding
  namespace: {{ .Release.Namespace }}
subjects:
- kind: ServiceAccount
  name: blocky-cronjob-sa
  namespace: {{ .Release.Namespace }}
roleRef:
  kind: Role
  name: configmap-access
  apiGroup: rbac.authorization.k8s.io
{{- end -}}