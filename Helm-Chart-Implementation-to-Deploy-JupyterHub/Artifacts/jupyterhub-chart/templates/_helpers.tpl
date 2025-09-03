{{/*
Expand the name of the chart.
*/}}
{{- define "jupyterhub.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "jupyterhub.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "jupyterhub.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "jupyterhub.labels" -}}
helm.sh/chart: {{ include "jupyterhub.chart" . }}
{{ include "jupyterhub.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "jupyterhub.selectorLabels" -}}
app.kubernetes.io/name: {{ include "jupyterhub.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "jupyterhub.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "jupyterhub.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create the data volume PVC name
*/}}
{{- define "jupyterhub.dataVolumeName" -}}
{{- printf "%s-data" (include "jupyterhub.fullname" .) }}
{{- end }}

{{/*
Create the notebook volume PVC name
*/}}
{{- define "jupyterhub.notebookVolumeName" -}}
{{- printf "%s-notebooks" (include "jupyterhub.fullname" .) }}
{{- end }}

{{/*
Create JupyterHub configuration
*/}}
{{- define "jupyterhub.config" -}}
c.JupyterHub.authenticator_class = 'jupyterhub.auth.DummyAuthenticator'
{{- if .Values.jupyterhub.auth.dummy.password }}
c.DummyAuthenticator.password = '{{ .Values.jupyterhub.auth.dummy.password }}'
{{- end }}
c.JupyterHub.spawner_class = '{{ .Values.jupyterhub.spawner.type }}'
c.KubeSpawner.image = '{{ .Values.jupyterhub.spawner.image }}'
c.KubeSpawner.cpu_limit = {{ .Values.jupyterhub.spawner.cpu_limit }}
c.KubeSpawner.mem_limit = '{{ .Values.jupyterhub.spawner.mem_limit }}'
c.KubeSpawner.storage_pvc_ensure = {{ ternary "True" "False" .Values.jupyterhub.spawner.storage_pvc_ensure }}
c.KubeSpawner.storage_class = '{{ .Values.jupyterhub.spawner.storage_class }}'
c.KubeSpawner.storage_capacity = '{{ .Values.jupyterhub.spawner.storage_capacity }}'
c.KubeSpawner.storage_access_modes = {{ .Values.jupyterhub.spawner.storage_access_modes | toJson }}
c.KubeSpawner.notebook_dir = '{{ .Values.jupyterhub.spawner.notebook_dir }}'
c.JupyterHub.ip = '0.0.0.0'
c.JupyterHub.port = 8000
c.JupyterHub.hub_ip = '0.0.0.0'
c.JupyterHub.hub_port = 8081
c.JupyterHub.allow_named_servers = True
c.JupyterHub.cleanup_servers = False
{{- end }}

