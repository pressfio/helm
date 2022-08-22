{{/*
Common labels
*/}}
{{- define "plendy.labels" -}}
{{ include "plendy.selectorLabels" . }}
app.kubernetes.io/version: {{ .Values.image.tag | quote }}
app.kubernetes.io/component: plendy-service
app.kubernetes.io/part-of: plendy
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "plendy.selectorLabels" -}}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}