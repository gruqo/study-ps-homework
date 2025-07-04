{{- define "env.template" }}
- name: {{ .env }}
  valueFrom:
    configMapKeyRef:
      name: conv-app-{{ .root.Values.common.configMapName }}-common
      key: {{ .env }}
{{- end }}

{{- define "secrets.template" }}
- name: {{ .name }}
  valueFrom:
    secretKeyRef:
      name: conv-app-secrets-common
      key: {{ .key }}
{{- end }}

{{- define "volumeMounts.template" }}
- name: {{ .service_name }}-{{ .volume.name }}
  mountPath: {{ .volume.mount_path }}
{{- end }}


{{- define "volume.template" }}
- name: {{ .service_name }}-{{ .volume.name }}
  persistentVolumeClaim:
    claimName: {{ .service_name }}-{{ .volume.name }}-pvc
{{- end }}