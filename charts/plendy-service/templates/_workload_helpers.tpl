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
{{- with .Values.image.pullSecrets -}}
imagePullSecrets:
  {{- toYaml . | nindent 2 }}
{{- end }}
restartPolicy: Always
serviceAccountName: 'plendy-service-account'
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
    memory: 256Mi
    cpu: "0.5"
  limits:
    memory: 512Mi
    cpu: "1"

{{- end }}