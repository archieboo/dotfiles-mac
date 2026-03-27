#!/bin/sh
# Address lookup for Neomutt — merges khard (saved contacts) + notmuch (mail history)
# Output format: email<TAB>name
query="$1"

# khard: saved contacts from iCloud
khard_results() {
  khard --skip-unparsable email --parsable "$1" 2>/dev/null \
    | awk -F'\t' 'NF>=2 { print $1 "\t" $2 }'
}

# notmuch: addresses from mail history (senders whose address matches query)
notmuch_results() {
  notmuch address --deduplicate=address \
      "from:${1}*" 2>/dev/null \
    | awk '
      /^.+ <.+>$/ {
        n = split($0, parts, " <")
        email = parts[n]
        sub(/>$/, "", email)
        name = ""
        for (i = 1; i < n; i++) name = name (i > 1 ? " <" : "") parts[i]
        print email "\t" name
        next
      }
      /^<.+>$/ { gsub(/[<>]/, ""); print; next }
      /^[^<]+@[^>]+$/ { print }
    '
}

{ khard_results "$query"; notmuch_results "$query"; } \
  | grep -v 'privaterelay\.appleid\.com' \
  | sort -t$'\t' -k1,1 -u \
  | sort -k2,2 \
  | head -30
