<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <style>
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; color: #333; margin: 0; padding: 20px; }
        .container { width: 95%; margin: auto; }
        
        /* Caixa de Alerta que substitui o campo 'text' do Mailgun */
        .alert-banner { 
            background-color: #fff3cd; 
            color: #856404; 
            padding: 15px; 
            border: 1px solid #ffeeba; 
            border-radius: 4px; 
            margin-bottom: 25px;
            border-left: 5px solid #ffc107;
        }

        h1 { color: #2c3e50; border-bottom: 2px solid #eee; padding-bottom: 10px; }
        table { border-collapse: collapse; width: 100%; margin-bottom: 20px; font-size: 13px; }
        th, td { border: 1px solid #ddd; padding: 12px; text-align: left; }
        th { background-color: #f8f9fa; font-weight: bold; }
        
        .CRITICAL { background-color: #700000 !important; color: white !important; font-weight: bold; text-align: center; }
        .HIGH { background-color: #d9534f !important; color: white !important; font-weight: bold; text-align: center; }
        .MEDIUM { background-color: #f0ad4e !important; color: white !important; font-weight: bold; text-align: center; }
        .LOW { background-color: #5bc0de !important; color: white !important; font-weight: bold; text-align: center; }
        
        .pkg-name { font-weight: bold; color: #2980b9; }
        .footer { font-size: 11px; color: #7f8c8d; margin-top: 20px; text-align: center; border-top: 1px solid #eee; padding-top: 10px; }
    </style>
</head>
<body>
    <div class="container">
        {{- if . }}
        
        <div class="alert-banner">
            <strong>⚠️ Atenção:</strong><br>

            Foram encontradas vulnerabilidades durante a execução da Pipeline. 
            Verifique os detalhes abaixo para aplicar as correções necessárias.

        </div>

        <h1>SAST - Trivy Report</h1>
        <p><strong>Target:</strong> {{ (index . 0).Target }}</p>
        <p><strong>Date:</strong> {{ now | date "2006-01-02 15:04" }}</p>

        {{- range . }}
        <h2 style="background: #ecf0f1; padding: 10px; border-radius: 4px;">Scanner: {{ .Type }}</h2>
        
        {{- if (gt (len .Vulnerabilities) 0) }}
        <table>
            <thead>
                <tr>
                    <th>Package</th>
                    <th>Vulnerability ID</th>
                    <th>Severity</th>
                    <th>Installed</th>
                    <th>Fixed Version</th>
                </tr>
            </thead>
            <tbody>
                {{- range .Vulnerabilities }}
                <tr>
                    <td class="pkg-name">{{ .PkgName }}</td>
                    <td><a href="https://avd.aquasec.com/nvd/{{ .VulnerabilityID }}">{{ .VulnerabilityID }}</a></td>
                    <td class="{{ .Vulnerability.Severity }}">{{ .Vulnerability.Severity }}</td>
                    <td>{{ .InstalledVersion }}</td>
                    <td><b>{{ if .FixedVersion }}{{ .FixedVersion }}{{ else }}Não disponível{{ end }}</b></td>
                </tr>
                {{- end }}
            </tbody>
        </table>
        {{- else }}
        <p style="color: #27ae60; font-weight: bold;">Nenhuma vulnerabilidade encontrada nesta seção.</p>
        {{- end }}

        {{- if (gt (len .Misconfigurations) 0) }}
        <h3 style="color: #e67e22;">Misconfigurations</h3>
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Check</th>
                    <th>Severity</th>
                    <th>Message</th>
                </tr>
            </thead>
            <tbody>
                {{- range .Misconfigurations }}
                <tr>
                    <td>{{ .ID }}</td>
                    <td>{{ .Title }}</td>
                    <td class="{{ .Severity }}">{{ .Severity }}</td>
                    <td style="font-size: 11px; color: #555;">{{ .Message }}</td>
                </tr>
                {{- end }}
            </tbody>
        </table>
        {{- end }}
        {{- end }}

        {{- else }}
        <div class="alert-banner" style="background-color: #d4edda; color: #155724; border-color: #c3e6cb; border-left-color: #28a745;">
            <strong>Sucesso!</strong> O relatório do Trivy retornou vazio (nenhuma ameaça detectada).
        </div>
        {{- end }}
        
        <div class="footer">
            Relatório gerado automaticamente via Jenkins Pipeline • Trivy v{{ .AppVersion | default "latest" }}
        </div>
    </div>
</body>
</html>