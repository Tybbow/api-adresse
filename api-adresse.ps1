# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    api-adresse.ps1                                    :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: Tybbow <tony.iskow@gosguard.com>           +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/10/25 10:38:25 by Tybbow            #+#    #+#              #
#    Updated: 2021/10/25 10:38:25 by Tybbow           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

$dataCity = Get-Content .\villes_france.csv | convertFrom-csv

Set-Content ".\resultat.txt" -value "date,label,responsetime"
foreach($line in $dataCity)
{
    $url = "http://api-adresse.data.gouv.fr/reverse/?lon="+$line.longitude+"&lat="+$line.lattitude

    $sw = [Diagnostics.StopWatch]::StartNew()
    $responseFromServer = Invoke-WebRequest -uri $url | ConvertFrom-Json
    $sw.Stop()

    $date = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    Write-Host $responseFromServer.features.properties.label "ResponseIn : " $sw.ElapsedMilliseconds
    Add-Content ".\resultat.txt" -value ($date+","+$responseFromServer.features.properties.label+","+$sw.ElapsedMilliseconds)
    Start-Sleep -Seconds 1
}