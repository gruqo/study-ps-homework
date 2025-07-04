{{- define "pv-pvc.template" }}
{{- $service := .service }}
{{- $Values := .Values }}
{{- if $service.volume }}
{{- range $volume := $service.volume }}
---
apiVersion: v1
kind: PersistentVolume
metadata:
  name: "{{ $service.name }}-{{ $volume.name }}-pv"
  namespace: {{ $Values.common.namespace }}
  labels:
    app: {{ $service.name }}
spec:
  storageClassName: {{ $volume.class_name }}
  capacity:
    storage: {{ $volume.capacity }}
  accessModes:
    - ReadWriteOnce
  persistentVolumeReclaimPolicy: Retain
  hostPath:
    path: /mnt/{{ $service.name }}-{{ $volume.name }}
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: "{{ $service.name }}-{{ $volume.name }}-pvc"
  namespace: {{ $Values.common.namespace }}
  labels:
    app: {{ $service.name }}
spec:
  storageClassName: {{ $volume.class_name }}
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: {{ $volume.capacity }}
{{- end }}
{{- end }}
{{- end }}
