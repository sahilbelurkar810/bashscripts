To use git login script on your ec2 instance

first you need to configure git ssh for that:
  1. Generate an ssh key on your instance using 
        ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
  2. Now do the following steps
      eval "$(ssh-agent -s)"
      ssh-add ~/.ssh/yourkeyname mostly something like id_rsa
  3. Now go to git hub settings > then ssh and gpg > new ssh

Now you need to generate an PAT(Personal Access Token)

Go to Developer Settings:
Click on your profile picture (top-right corner).
Navigate to Settings → Developer settings.

Select Personal Access Tokens:
Under Developer settings, click on Personal access tokens → Tokens (classic).

Generate a New Token:
Click Generate new token (classic).
Add a note for the token (e.g., "For Git operations").
Set an expiration date (e.g., 30 days, 90 days, or no expiration).
Select the necessary scopes (permissions):
For general Git operations: Enable repo.
For managing settings, workflows, etc., enable other scopes as needed.
Generate and Copy the Token:

Click Generate token.
Copy the token immediately and save it securely (e.g., in a password manager). You won't be able to view it again later.
     
you can directly integrate the credential in the script but make sure you dont publish it, and the best way would be to automate the whole process further!.
