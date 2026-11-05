# hackathon-kit (Codex CLI용)

여러 터미널을 팀원처럼 나눠 쓰는 해커톤용 Codex 스킬 모음.
`docs/00_병목 SSOT.md` 하나를 단일 기준(SSOT)으로 삼아, 각 터미널이 자기 병목을 맡고 진행 상황을 기록한다.
SSOT는 위쪽(1~4절)이 사람이 읽는 요약, 아래쪽(5절~)이 AI 작업 영역이다.

## 설치 (대회 작업 폴더에서)
```bash
git clone https://github.com/<아이디>/hackathon-kit.git ~/kit
bash ~/kit/install.sh
```
그다음 터미널마다 같은 폴더에서 `codex -s workspace-write -a on-request`를 실행하고, `/skills`로 목록을 확인한다.
(옛 `--full-auto` 옵션은 최신 Codex에서 삭제됨)

## 스킬 (호출은 `$이름`)
| 호출 | 뜻 | 누가 | 하는 일 |
|---|---|---|---|
| `$wjdfl 문제…` | 정리 | 리드 | 요구사항·채점 기준·주최 의도 → `docs/01_정리.md` |
| `$dlgo` | 이해 | 리드 | 컬럼·관계·입력→출력 흐름 설명 → `docs/02_이해.md` |
| `$qudahr` | 병목 | 리드 | 병목 나누기, 병목별 제한사항·아이디어 2개 정리, SSOT 생성 |
| `$rngus B#` | 구현 | 팀원 | A·B·A+B 치명적 결함 검토 → 문제없으면 바로 구현 |
| `$cnrk B#` | 추가 | 팀원 | 치명적 결함 보완책 → 빠른 실험으로 효과 확인 → 구현 |
| `$xptmxm B#` | 테스트 | 팀원 | 병목 단위 테스트 |
| `$cowja` | 채점 | 리드 | 전체 파이프라인 연결 후 채점 기준으로 평가 |
| `$wpcnf` | 제출 | 리드 | 제출 형식 점검과 설명 문서 (선택) |

모든 스킬은 명시적으로 부를 때만 작동한다(`agents/openai.yaml`의 `allow_implicit_invocation: false`).

## 터미널 배치 예시
- 터미널 1 (리드): `$wjdfl 문제…` → `$dlgo` → `$qudahr`
- 터미널 2: `$rngus B0` → `$xptmxm B0`
- 터미널 3: `$rngus B1` → `$xptmxm B1`
- 모두 통과하면 터미널 1: `$cowja` → `$wpcnf`

## 주의
- 공개 저장소다. API 키, 대회 문제·데이터를 이 레포에 커밋하지 않는다.
- `workspace-write` 모드에서는 네트워크가 기본 차단된다. 필요한 패키지는 Codex 밖의 터미널에서 미리 설치한다.
