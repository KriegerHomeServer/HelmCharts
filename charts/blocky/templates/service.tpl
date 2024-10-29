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
    - name: dns-tcp
      port: 53
      targetPort: 53
      protocol: TCP
    - name: dns-udp
      port: 53
      targetPort: 53
      protocol: UDP
    - name: http
      port: 80
      targetPort: {{ .Values.deployment.httpPort | default 4000 }}
      protocol: TCP
    - name: https
      port: 443
      targetPort: {{ .Values.deployment.httpPort | default 4000 }}
      protocol: TCP
  selector:
    app: blocky
{{- end -}}