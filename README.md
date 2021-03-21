# 가벼운 자산관리
# 개인용 자산관리 포트폴리오 앱
## 개발 환경
* 데이터베이스 - Sqlite

---

## 1. 메인 화면(자산 포트폴리오 화면)
* 등록 된 자산들을 원형 그래프로 확인할 수 있다.
<img src="https://user-images.githubusercontent.com/79705809/111898245-2fe99080-8a68-11eb-9dde-93eee403a169.jpg"  width="324" height="720">
* 메인 페이지에서 다양한 화면으로 이동할 수 있다.

---

## 2. 주식 포트폴리오 화면
* 등록된 자산 중 '주식'으로 등록된 자산을 원형 그래프로 확인할 수 있다.

<img src="https://user-images.githubusercontent.com/79705809/111898254-38da6200-8a68-11eb-9d3d-d9e0616e54a6.jpg"  width="324" height="720">

---

## 3. 자산 관리 화면
* 등록된 자산들을 데이터 테이블로 확인할 수 있고 자산과 관련하여 CRUD가 가능하다.

<img src="https://user-images.githubusercontent.com/79705809/111898255-3972f880-8a68-11eb-88cb-0a20d17af62f.jpg"  width="324" height="720">

## 3. 자산 관리 화면(자산 삭제)
* 삭제하고 싶은 자산 선택 후 '삭제하기' 버튼을 통해 자산 삭제 가능

<img src="https://user-images.githubusercontent.com/79705809/111898251-37a93500-8a68-11eb-87cf-378e760fecfc.jpg"  width="324" height="720">

## 3. 자산 관리 화면(자산 수정)
* 수정하고 싶은 자산의 '금액'탭을 선택 후 금액을 수정하여 입력한다. '완료'버튼을 클릭하면 수정된 내용이 적용된다. 

<img src="https://user-images.githubusercontent.com/79705809/111898252-3841cb80-8a68-11eb-9d5a-22969444a913.jpg"  width="324" height="720">

## 3. 자산 관리 화면(자산 등록)
* '등록하기'버튼을 클릭하면 자산을 등록할 수 있다.

<img src="https://user-images.githubusercontent.com/79705809/111898256-3972f880-8a68-11eb-916f-9aa6333bb93d.jpg"  width="324" height="720">

* 자산 정보 미 입력시 예외처리

<img src="https://user-images.githubusercontent.com/79705809/111898634-af785f00-8a6a-11eb-9f1e-2cd76593c661.jpg"  width="324" height="720">

* 기본키 중복 시 예외처리

<img src="https://user-images.githubusercontent.com/79705809/111898635-b0a98c00-8a6a-11eb-8b06-a3ec4e524a0a.jpg"  width="324" height="720">

## 4. 자산 비중 화면
* 등록된 자산들의 안전/위험 자산의 비중을 확인할 수 있다.

<img src="https://user-images.githubusercontent.com/79705809/111898253-38da6200-8a68-11eb-879e-9e01a1651853.jpg"  width="324" height="720">
