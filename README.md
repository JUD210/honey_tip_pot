# Terminal Setup Guide

Oh My Zsh + Powerlevel10k 테마로 터미널을 한 방에 세팅하는 가이드입니다.

## Quick Start

```bash
# 1. 원하는 디렉토리로 이동
cd ~

# 2. 이 레포를 클론
git clone https://github.com/JUD210/honey_tip_pot

# 3. terminal_settings 디렉토리로 이동
cd ~/honey_tip_pot/terminal_settings

# 4. 초기화 스크립트 실행
source init_my_shell.sh

# 5. (선택) Powerlevel10k 커스터마이징
# p10k configure
#
# 기본(권장) 셋팅: nnny 111 22 1111 n 1 (y)
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
| `.zshrc` | Zsh 설정 (멀티 OS 지원: macOS, WSL2, Git Bash, Termux) |
| `.my_aliases.sh` | 단축 명령어 모음 (git, docker, kubectl, flutter 등) |
| `.vimrc` | Vim 기본 설정 |
| `.bashrc` | Bash 실행 시 zsh로 전환 |
| `.p10k.zsh` | Powerlevel10k 테마 설정 |
| `.gitconfig` | Git 설정 (OS에 따라 `.mac.gitconfig` 또는 `.linux.gitconfig` 사용) |

## After Setup

### Git 사용자 설정 (필수)

설치 후 반드시 본인의 git 사용자 정보를 설정하세요:

```bash
git config --global user.name "Your Name"
git config --global user.email "your_email@example.com"
```

### 주요 단축 명령어 (alias)

<details>
<summary>Git aliases</summary>

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
| `gl1` | `git log` (pretty format with date/author) |
| `gla` | `git log --oneline --graph --all` |
| `gdf` | `git diff` |

</details>

<details>
<summary>Docker / Kubernetes aliases</summary>

| Alias | Command |
|---|---|
| `dk` | `docker` |
| `dkps` | `docker ps` |
| `dkc` | `docker-compose` |
| `kc` | `kubectl` |
| `kcg` | `kubectl get` |

</details>

<details>
<summary>Navigation aliases</summary>

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

- **프로젝트별 cd 단축키**: `.my_aliases.sh`의 `cd settings` 섹션에 추가
- **Powerlevel10k 재설정**: `p10k configure`
- **alias 추가/수정**: `.my_aliases.sh` 파일 편집 후 `als`로 즉시 적용
