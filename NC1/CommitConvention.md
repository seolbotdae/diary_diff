# 커밋메시지 작성 방법

``` bash
type: title

body
```

<br>

# type의 종류
## Feat

→ 새로운 기능을 추가했을 경우

## Refactor

→ 새로운 기능이나 버그 수정 없이 코드의 모양만 바꿨을 때

→ 변수명 수정이나, 함수 리팩토링 등등 코드 동작의 수정이 없을 때 선택하세요

## Fix

→ 버그 또는 오탈자를 고친 경우!

→ “내가 의도하지 않은 동작이면 모두 다 버그이다”

## Style

→ formatter 수정과 같은 사소한 수정일 때!

→ EX)

// BEFORE
Image("Tomato").resizable().scaledToFit()

// AFTER
Image("Tomato")
    .resizable()
    .scaledToFit()
 
## Chore

→ 코드 수정은 아니고, 프로젝트 관련 환경 설정할 때!

→ 에셋 변경, 폴더 구조 변경이나, 패키지 매니저 설정할 경우

## Docs

→ README 등 문서 관련 수정일 때!

## Remove

→ 사용하지 않는 파일이나 폴더를 삭제할 때!

## Rename

→ 파일이나 폴더명을 수정하는 경우!

<br>

# 작성 예시
title: 수정한 내용을 모두 포함하는 한 줄로 작성합니다.

body: 어떻게 했는지가 아닌, 무엇을 왜 했는지를 작성합니다.
