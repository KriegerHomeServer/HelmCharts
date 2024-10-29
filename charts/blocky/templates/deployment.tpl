{{- define "helm-charts.blocky.deployment" -}}
apiVersion: apps/v1
kind: Deployment
metadata:
  name: blocky
  namespace: {{ .Values.namespace }}
  labels:
    app: blocky
spec:
  replicas: {{ .Values.deployment.replicaCount | default 1 }}
  selector:
    matchLabels:
      app: blocky
  strategy:
    type: Recreate
  template:
    metadata:
      labels:
        app: blocky
    spec:
      containers:
        - name: app-blocky
          image: "{{ .Values.deployment.image.repository | default "spx01/blocky" }}:{{ .Values.deployment.image.tag | default "latest" }}"
          imagePullPolicy: {{ .Values.deployment.image.pullPolicy | default "IfNotPresent" }}
          resources:
            limits:
              cpu: {{ .Values.deployment.resources.limits.cpu | default "50m" }}
              memory: {{ .Values.deployment.resources.limits.memory | default "64Mi" }}
            requests:
              cpu: {{ .Values.deployment.resources.requests.cpu | default "50m" }}
              memory: {{ .Values.deployment.resources.requests.memory | default "64Mi" }}
          volumeMounts:
            - name: blocky-config
              mountPath: /app/config.yaml
          ports:
            - containerPort: 53
            - containerPort: {{ .Values.deployment.httpPort | default 4000 }}
      volumes:
        - name: blocky-config
          configMap:
            name: blocky-configuration
            items:
              - key: config.yaml
      restartPolicy: Always
{{- end -}}