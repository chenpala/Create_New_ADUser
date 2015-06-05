#requires -version 2
<#
.SYNOPSIS
  To create an elevated user account in AD. Yes

.DESCRIPTION
  This script will craete a new user based on intereactive unpiut from the user running the script. It will then set the user to a disabled state and email the relevant people for approvals. Once approved the user can then be enabled.
  
.PARAMETER <Parameter_Name>
  TBC  <Brief description of parameter input required. Repeat this attribute if required>

.INPUTS
  The script will call for the following inputs by the user:
    - Submitters Credentials
    - First Name
    - Last Name
    - Logon (Account Name)
    - LANDesk Ticket Number
    - Temporary or Permanent 


.OUTPUTS
  User created in AD in disabled mode
  Email sent to approvers from submitter's email address

.NOTES
  Version:        0.1
  Author:         Fahad Talib
  Creation Date:  24/05/2015
  Purpose/Change: Create AD User
  
.EXAMPLE
  . Create_NewADUser.ps1
#>
 
#----------User Variables----------#
 
$Submitter = Get-Credential
$UserAccount
$Landesk
$Permanant

#----------Set Variables----------#

$Approver = Get-ADUser
$ApproversEmail = $Approver.Email
$Date = Get-Date
$DomainController = Get-ADDomainController -
$Approval = Set-ADUser -Enabled True -Description "Approved by $Approver on Todays Date. Reference: $Landesk"
$UserCreated = Set-ADUser -Enabled True -Description "Sent for approval to $Approver by $Submitter on Todays Date. Reference: $Landesk"

#----------Execution----------#
 
 "AD User Creation"

$UserAccount = Read-Host "What is the Users Account Number e.g. u12345?"
 
 #Check input for $UserAccount
 While ($UserAccount.Length -ne 6 -or !$UserAccount.ToLower().StartsWith('u'))
    {
        $UserAccount = Read-Host "Incorrect Format for User Account Entry. Please enter the User's Account Number e.g. u12345"
    }

 # Create User

 New-ADUser [-Name] <string> [-WhatIf] [-Confirm] [-AccountExpirationDate <datetime>] [-AccountNotDelegated <bool>] [-AccountPassword <securestring>] 
    [-AllowReversiblePasswordEncryption <bool>] [-AuthenticationPolicy <ADAuthenticationPolicy>] [-AuthenticationPolicySilo <ADAuthenticationPolicySilo>] [-AuthType 
    <ADAuthType> {Negotiate | Basic}] [-CannotChangePassword <bool>] [-Certificates <X509Certificate[]>] [-ChangePasswordAtLogon <bool>] [-City <string>] [-Company <string>] 
    [-CompoundIdentitySupported <bool>] [-Country <string>] [-Credential <pscredential>] [-Department <string>] [-Description <string>] [-DisplayName <string>] [-Division 
    <string>] [-EmailAddress <string>] [-EmployeeID <string>] [-EmployeeNumber <string>] [-Enabled <bool>] [-Fax <string>] [-GivenName <string>] [-HomeDirectory <string>] 
    [-HomeDrive <string>] [-HomePage <string>] [-HomePhone <string>] [-Initials <string>] [-Instance <ADUser>] [-KerberosEncryptionType <ADKerberosEncryptionType> {None | DES 
    | RC4 | AES128 | AES256}] [-LogonWorkstations <string>] [-Manager <ADUser>] [-MobilePhone <string>] [-Office <string>] [-OfficePhone <string>] [-Organization <string>] 
    [-OtherAttributes <hashtable>] [-OtherName <string>] [-PassThru] [-PasswordNeverExpires <bool>] [-PasswordNotRequired <bool>] [-Path <string>] [-POBox <string>] 
    [-PostalCode <string>] [-PrincipalsAllowedToDelegateToAccount <ADPrincipal[]>] [-ProfilePath <string>] [-SamAccountName <string>] [-ScriptPath <string>] [-Server 
    <string>] [-ServicePrincipalNames <string[]>] [-SmartcardLogonRequired <bool>] [-State <string>] [-StreetAddress <string>] [-Surname <string>] [-Title <string>] 
    [-TrustedForDelegation <bool>] [-Type <string>] [-UserPrincipalName <string>]  [<CommonParameters>]

# Add User Created Comment
$UserCreated

# Send Email


# Run This Command to Approve
$Approval
