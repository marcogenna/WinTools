Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Create form
$form = New-Object System.Windows.Forms.Form
$form.Text = "User Management"
$form.Size = New-Object System.Drawing.Size(350,200)
$form.StartPosition = "CenterScreen"
$form.FormBorderStyle = "FixedSingle"

# Create controls
$label = New-Object System.Windows.Forms.Label
$label.Text = "Username:"
$label.Location = New-Object System.Drawing.Point(10,20)
$label.Size = New-Object System.Drawing.Size(60,20)

$textbox = New-Object System.Windows.Forms.TextBox
$textbox.Location = New-Object System.Drawing.Point(80,20)
$textbox.Size = New-Object System.Drawing.Size(150,20)

$addButton = New-Object System.Windows.Forms.Button
$addButton.Location = New-Object System.Drawing.Point(10,50)
$addButton.Size = New-Object System.Drawing.Size(100,30)
$addButton.Text = "Add User"
$addButton.Add_Click({
    $username = $textbox.Text
    if ($username -ne "") {
        net user $username /add
        Write-Host "User $username added."
    } else {
        Write-Host "Please enter a username."
    }
})

$removeButton = New-Object System.Windows.Forms.Button
$removeButton.Location = New-Object System.Drawing.Point(120,50)
$removeButton.Size = New-Object System.Drawing.Size(100,30)
$removeButton.Text = "Remove User"
$removeButton.Add_Click({
    $username = $textbox.Text
    if ($username -ne "") {
        net user $username /delete
        Write-Host "User $username removed."
    } else {
        Write-Host "Please enter a username."
    }
})

$disableButton = New-Object System.Windows.Forms.Button
$disableButton.Location = New-Object System.Drawing.Point(230,50)
$disableButton.Size = New-Object System.Drawing.Size(100,30)
$disableButton.Text = "Disable User"
$disableButton.Add_Click({
    $username = $textbox.Text
    if ($username -ne "") {
        net user $username /active:no
        Write-Host "User $username disabled."
    } else {
        Write-Host "Please enter a username."
    }
})

$addGroupButton = New-Object System.Windows.Forms.Button
$addGroupButton.Location = New-Object System.Drawing.Point(10,90)
$addGroupButton.Size = New-Object System.Drawing.Size(150,30)
$addGroupButton.Text = "Add User to Group"
$addGroupButton.Add_Click({
    $username = $textbox.Text
    $groupname = "Administrators"  # Change this to the desired group name
    if ($username -ne "") {
        Add-LocalGroupMember -Group $groupname -Member $username
        Write-Host "User $username added to group $groupname."
    } else {
        Write-Host "Please enter a username."
    }
})

# Add controls to the form
$form.Controls.Add($label)
$form.Controls.Add($textbox)
$form.Controls.Add($addButton)
$form.Controls.Add($removeButton)
$form.Controls.Add($disableButton)
$form.Controls.Add($addGroupButton)

# Show the form
$form.ShowDialog()
