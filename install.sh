#!/usr/bin/env bash
# 해커톤 키트(Codex) 설치 — 대회 작업 폴더에서 실행:  bash ~/kit/install.sh
set -e
KIT="$(cd "$(dirname "$0")" && pwd)"
DEST="$(pwd)"

if [ "$KIT" = "$DEST" ]; then
  echo "키트 폴더가 아니라 대회 작업 폴더로 이동한 뒤 실행하세요."; exit 1
fi

mkdir -p "$DEST/.agents/skills" "$DEST/docs" "$DEST/src" "$DEST/tests" "$DEST/eval" "$DEST/snapshots"
cp -R "$KIT"/skills/* "$DEST/.agents/skills/"

MARK="<!-- hackathon-kit -->"
if [ -f "$DEST/AGENTS.md" ]; then
  if grep -q "$MARK" "$DEST/AGENTS.md"; then
    echo "AGENTS.md에 팀 규칙이 이미 있어 건너뜁니다."
  else
    printf "\n\n" >> "$DEST/AGENTS.md"
    cat "$KIT/AGENTS.md" >> "$DEST/AGENTS.md"
    echo "기존 AGENTS.md 뒤에 팀 규칙을 덧붙였습니다."
  fi
else
  cp "$KIT/AGENTS.md" "$DEST/AGENTS.md"
fi

# git 저장소여야 Codex가 쓰기 가능 모드(Auto)를 권장한다
if ! git -C "$DEST" rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  git -C "$DEST" init -q && echo "git 저장소를 새로 만들었습니다."
fi

echo ""
echo "설치 완료. 각 터미널에서 이 폴더로 와서 실행:  codex --full-auto"
echo "Codex 안에서 /skills 로 7개가 보이는지 확인하세요."
echo "리드: \$wjdfl → \$dlgo → \$qudahr → \$cowja → \$wpcnf"
echo "팀원: \$qudahr B# → (\$cnrk B#) → \$xptmxm B#"
