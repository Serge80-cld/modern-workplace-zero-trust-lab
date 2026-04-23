# Ajout du script de préparation AD pour Cloud Sync
============================================
# Script : prepare-ad.ps1
# Objectif : Préparer l'Active Directory pour Cloud Sync
# Auteur : SergeLab
# ============================================

Write-Host "Création de l'OU CloudSync..." -ForegroundColor Cyan
New-ADOrganizationalUnit -Name "CloudSync" -Path "DC=sergelab,DC=local" -ErrorAction SilentlyContinue

Write-Host "Création des utilisateurs..." -ForegroundColor Cyan

$users = @(
    @{Name="Alice Cloud"; Sam="alice.cloud"; UPN="alice.cloud@sergelab.local"},
    @{Name="Bob Cloud"; Sam="bob.cloud"; UPN="bob.cloud@sergelab.local"},
    @{Name="Charlie Cloud"; Sam="charlie.cloud"; UPN="charlie.cloud@sergelab.local"}
)

foreach ($u in $users) {
    New-ADUser -Name $u.Name `
               -SamAccountName $u.Sam `
               -UserPrincipalName $u.UPN `
               -AccountPassword (ConvertTo-SecureString "P@ssw0rd!" -AsPlainText -Force) `
               -Enabled $true `
               -Path "OU=CloudSync,DC=sergelab,DC=local" `
               -ErrorAction SilentlyContinue

    Write-Host "Utilisateur créé : $($u.Name)" -ForegroundColor Green
}

Write-Host "Création du groupe CloudSync-Users..." -ForegroundColor Cyan
New-ADGroup -Name "CloudSync-Users" -GroupScope Global -Path "OU=CloudSync,DC=sergelab,DC=local" -ErrorAction SilentlyContinue

Write-Host "Ajout des utilisateurs au groupe..." -ForegroundColor Cyan
Add-ADGroupMember -Identity "CloudSync-Users" -Members "alice.cloud","bob.cloud","charlie.cloud" -ErrorAction SilentlyContinue

Write-Host "Préparation AD terminée avec succès !" -ForegroundColor Green
