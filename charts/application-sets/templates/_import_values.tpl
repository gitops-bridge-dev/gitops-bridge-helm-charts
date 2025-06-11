{{/*
Import and merge values from component files based on enabled flags
*/}}
{{- define "application-sets.importValues" -}}
{{- $result := dict -}}

{{/* Iterate over all components in mergeValues */}}
{{- range $component, $config := .Values.mergeValues }}
  {{- if and $config (eq (toString (default false $config.use)) "true") }}
    {{- $valuesFile := printf "values/%s.yaml" $component }}
    {{- $componentValues := $.Files.Get $valuesFile | fromYaml }}
    {{- if $componentValues }}
      {{- $result = merge $result $componentValues }}
    {{- end }}
  {{- end }}
{{- end }}

{{/* Return the merged values */}}
{{- $result | toYaml }}
{{- end }}
