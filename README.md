# Terminal Setup Guide

Oh My Zsh + Powerlevel10k 테마로 터미널을 한 방에 세팅하는 가이드입니다.

## Quick Start (Ubuntu)

```bash
# 1. 작업 디렉토리 생성 및 이동
mkdir -p ~/_ALL_CODES && cd ~/_ALL_CODES

# 2. 이 레포를 클론
git clone https://github.com/JUD210/honey_tip_pot

# 3. 초기화 스크립트 실행
cd ~/_ALL_CODES/honey_tip_pot/terminal_settings
bash init_my_shell.sh

# 4. Git 사용자 설정 (필수!)
git config --global user.name "Your Name"
git config --global user.email "your@email.com"

# 5. 터미널 재시작 후, Powerlevel10k 설정
# p10k configure
# 권장 셋팅: ynn 111 22 2141 2y 1 (y)
```

## What Gets Installed

- **zsh** - Z Shell
- **less** - Pager
- **Oh My Zsh** - zsh 프레임워크
- **Powerlevel10k** - 깔끔한 프롬프트 테마

## What Gets Configured

`init_my_shell.sh` 실행 시 다음 파일들이 홈 디렉토리에 심볼릭 링크로 생성됩니다:

| File | Description |
|---|---|
| `.zshrc` | Zsh 설정 (멀티 OS 지원: macOS, Ubuntu/WSL2, Git Bash, Termux) |
| `.my_aliases.sh` | 단축 명령어 모음 (git, docker, kubectl, flutter 등) |
| `.vimrc` | Vim 기본 설정 |
| `.bashrc` | Bash 실행 시 zsh로 자동 전환 |
| `.gitconfig` | Git 설정 (OS에 따라 `.mac.gitconfig` 또는 `.linux.gitconfig` 사용) |

## 주요 단축 명령어 (alias)

<details>
<summary>Git</summary>

| Alias | Command |
|---|---|
| `gs` | `git status` |
| `ga .` | `git add .` |
| `gcm` | `git commit -m` |
| `gps` | `git push` |
| `gpl` | `git pull` |
| `gco` | `git checkout` |
| `gcob` | `git checkout -b` |
| `gbr` | `git branch` |
| `gl1` | `git log` (pretty format: date + author) |
| `gla` | `git log --oneline --graph --all` |
| `gdf` | `git diff` |

</details>

<details>
<summary>Docker / Kubernetes</summary>

| Alias | Command |
|---|---|
| `dk` | `docker` |
| `dkps` | `docker ps` |
| `dkc` | `docker-compose` |
| `kc` | `kubectl` |
| `kcg` | `kubectl get` |

</details>

<details>
<summary>Navigation</summary>

| Alias | Command |
|---|---|
| `..` | `cd ..` |
| `...` | `cd ../..` |
| `l` | `ls -lpA` |
| `c` | `clear` |
| `p` | `pwd` |

</details>

### less 사용법 (git log 등에서)

- `q`: 나가기
- `d`: 아래로 페이지 이동
- `u`: 위로 페이지 이동

## Customization

- **Powerlevel10k 재설정**: `p10k configure`
- **alias 추가/수정**: `.my_aliases.sh` 편집 후 `als`로 즉시 적용
- **프로젝트별 cd 단축키**: `.my_aliases.sh`의 `cd settings` 섹션에 추가
