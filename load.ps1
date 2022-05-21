# Copy new image data
scp *.png remarkable:/usr/share/remarkable/templates/
scp *.svg remarkable:/usr/share/remarkable/templates/

# Copy original templates.json
Remove-Item -R -Force ./templates.original.json
scp remarkable:/usr/share/remarkable/templates/templates.json ./templates.original.json

# Backup original templates.json on-device
ssh remarkable "mv /usr/share/remarkable/templates/templates.json /usr/share/remarkable/templates/templates.original.json"

# Merge jsons (new = original + additions)
Remove-Item -R -Force ./templates.merged.json
jq -n '{ templates: [ inputs.templates ] | add }' templates.original.json templates.addition.json > templates.merged.json

# Copy new templates.json
scp templates.merged.json remarkable:/usr/share/remarkable/templates/templates.json
