{{- define "helm-charts.blocky.roles" -}}
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: configmap-access
  namespace: {{ .Release.Namespace }}
rules:
- apiGroups: [""]
  resources: ["configmaps"]
  verbs: ["get", "list", "watch", "create", "update", "delete"]
{{- end -}}