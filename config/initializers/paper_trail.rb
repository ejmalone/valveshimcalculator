PaperTrail.config.enabled = true

# use JSON instead of YAML because of https://discuss.rubyonrails.org/t/cve-2022-32224-possible-rce-escalation-bug-with-serialized-columns-in-active-record/81017/1
PaperTrail.serializer = PaperTrail::Serializers::JSON