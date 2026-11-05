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

MARK="<!-- hackathon-kit -->"; END="<!-- /hackathon-kit -->"
if [ -f "$DEST/AGENTS.md" ]; then
  if grep -q "$MARK" "$DEST/AGENTS.md"; then
    # 예전 팀 규칙 블록을 지우고 새 버전으로 교체 (끝 표시가 없으면 파일 끝까지)
    awk -v m="$MARK" -v e="$END" '$0==m{skip=1;next} skip&&$0==e{skip=0;next} !skip' "$DEST/AGENTS.md" > "$DEST/AGENTS.md.tmp"
    mv "$DEST/AGENTS.md.tmp" "$DEST/AGENTS.md"
    echo "팀 규칙을 최신 버전으로 교체했습니다."
  fi
  if [ -s "$DEST/AGENTS.md" ]; then printf "\n" >> "$DEST/AGENTS.md"; fi
  cat "$KIT/AGENTS.md" >> "$DEST/AGENTS.md"
else
  cp "$KIT/AGENTS.md" "$DEST/AGENTS.md"
fi

# git 저장소여야 Codex가 쓰기 가능 모드(Auto)를 권장한다
if ! git -C "$DEST" rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  git -C "$DEST" init -q && echo "git 저장소를 새로 만들었습니다."
fi

echo ""
echo "설치 완료. 각 터미널에서 이 폴더로 와서 실행:  codex -s workspace-write -a on-request"
echo "Codex 안에서 /skills 로 8개가 보이는지 확인하세요."
echo "리드: \$wjdfl → \$dlgo → \$qudahr → \$cowja → \$wpcnf"
echo "팀원: \$rngus B# → (\$cnrk B#) → \$xptmxm B#"
