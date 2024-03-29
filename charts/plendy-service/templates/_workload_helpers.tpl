{{/*
Default pod security context
https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.22/#podsecuritycontext-v1-core
*/}}
{{- define "plendy.defaultPodSecurityContext" -}}
fsGroup: 2000
fsGroupChangePolicy: 'OnRootMismatch'
runAsGroup: 3000
runAsNonRoot: true
runAsUser: 1000
{{- end }}

{{/*
Default pod spec
https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.22/#podspec-v1-core
*/}}
{{- define "plendy.defaultPodSpec" -}}
restartPolicy: Always
serviceAccountName: 'plendy-svc'
securityContext:
  {{- include "plendy.defaultPodSecurityContext" . | nindent 2 }}
{{- end }}

{{/*
Default goteam container spec
https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.22/#container-v1-core
*/}}
{{- define "plendy.defaultContainerSpec" -}}
securityContext:
  capabilities:
    add:
      - NET_BIND_SERVICE
  # readOnlyRootFilesystem: true
  allowPrivilegeEscalation: false
  privileged: false
image: '{{ .Values.image.registry }}/{{ .Values.image.repo }}:{{ .Values.image.tag }}'
imagePullPolicy: {{ .Values.image.pullPolicy }}
resources:
  requests:
    memory: 128Mi
    cpu: "100m"
  limits:
    memory: 256Mi
    cpu: "200m"

{{- end }}