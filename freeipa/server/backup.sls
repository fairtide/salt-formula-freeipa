{%- from "freeipa/map.jinja" import server with context %}

{%- if server.get('backup', {}).get('enabled', True) %}

/sbin/ipa-backup:
    cron.present:
      - identifier: freeipa-backup
      - user: root
{%- if server.backup.special is defined %}
      - special: '{{ server.backup.special }}'
{% else %}
      - minute: '{{ server.backup.minute if server.backup.minute is defined else 10 }}'
      - hour: '{{ server.backup.hour if server.backup.hour is defined else 0 }}'
      - daymonth: '{{ server.backup.daymonth if server.backup.daymonth is defined else "*" }}'
      - month: '{{ server.backup.month if server.backup.month is defined else "*" }}'
      - dayweek: '{{ server.backup.dayweek if server.backup.dayweek is defined else "*" }}'
{%- endif %}

{%- endif %}