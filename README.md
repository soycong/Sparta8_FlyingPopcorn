![image](https://github.com/user-attachments/assets/69b6b1d6-1ab4-4474-a4fc-fc6d09471228)# 🍿 FlyingPopcorn
팀 2DongJin의 영화 예매 앱 프로젝트, FlyingPopcorn입니다.

## 📚 Tech Stacks
<div>
  <a href="https://developer.apple.com/xcode/" target="_blank">
    <img src="https://img.shields.io/badge/Xcode_16.1-147EFB?style=for-the-badge&logo=xcode&logoColor=white" alt="Xcode">
  </a>
  <a href="https://swift.org/" target="_blank">
    <img src="https://img.shields.io/badge/Swift_5-F05138?style=for-the-badge&logo=swift&logoColor=white" alt="Swift">
  </a>
  <br>
  <a href="https://developer.apple.com/documentation/uikit" target="_blank">
    <img src="https://img.shields.io/badge/UIKit-2396F3?style=for-the-badge&logo=uikit&logoColor=white" alt="UIKit">
  </a>
  <a href="https://github.com/SnapKit/SnapKit" target="_blank">
    <img src="https://img.shields.io/badge/SnapKit-00aeb9?style=for-the-badge&logoColor=white" alt="SnapKit">
  </a>
  <a href="https://github.com/devxoul/Then" target="_blank">
    <img src="https://img.shields.io/badge/Then-00aeb9?style=for-the-badge&logoColor=white" alt="Then">
  </a>
  <br>
  <a href="https://github.com/onevcat/Kingfisher" target="_blank">
    <img src="https://img.shields.io/badge/Kingfisher-1c8dfc?style=for-the-badge&logoColor=white" alt="Then">
  </a>
  <a href="https://github.com/Alamofire/Alamofire" target="_blank">
    <img src="https://img.shields.io/badge/AlamoFire-d6401b?style=for-the-badge&logoColor=white" alt="Then">
  </a>
  <br>
  <a href="https://git-fork.com/" target="_blank">
    <img src="https://img.shields.io/badge/fork-1c8dfc?style=for-the-badge&logoColor=white" alt="Then">
  </a>
  <a href="https://www.gitkraken.com/" target="_blank">
    <img src="https://img.shields.io/badge/gitkraken-179287?style=for-the-badge&logo=gitkraken&logoColor=white" alt="GitKraken">
  </a>
  <a href="https://github.com/" target="_blank">
    <img src="https://img.shields.io/badge/github-181717?style=for-the-badge&logo=github&logoColor=white" alt="GitHub">
  </a>
  <br>
</div>

## 👥 The Team
| Name     | GitHub   | Roles    | Main Developments |
|:--------:| -------- | -------- | ----------------- |
| 김하민 <br> ( Hamin Kim ) | [@dev-hamin-kim](https://github.com/dev-hamin-kim) | Quality Architect <br> Decision Gamemaster | 영화 예매 화면 <br> 영화 예매 처리 모델 |
| 박시연 <br> ( Siyeon Park ) | [@sy0201](https://github.com/sy0201) | Project Coordinator <br> Present Lead | 영화 상세 화면, 하단 탭바, 화면 연결 <br> 영화 데이터 네트워크 모델 |
| 박채현 <br> ( Chaehyun Park ) | [@chaehyunp](https://github.com/chaehyunp) | Design Specialist <br> Vibe Energizer | 인트로/로고 디자인, 로그인/회원가입 화면 <br> 회원 정보 관리 모델 |
| 백서희 <br> ( Seohui Baek ) | [@soycong](https://github.com/soycong) | Design Organizer <br> Present Coordinator | 검색 화면, 마이페이지/예매내역 화면 <br> 영화 검색 모델 |
| 황도일 <br> ( Doyle Hwang ) | [@DoyleHWorks](https://github.com/DoyleHWorks) | Git Admin <br> Docs Manager | 홈 화면, 화면 연결 보조 <br> 팀 리딩, 프로젝트 리소스 관리 |

## ⏰ Project Scope
- **시작일**: 2024/12/13
- **종료예정일**: 2024/12/20

## 🖼️ Preview
(Coming Soon)

## 🏷 Main Features
#### 로그인/회원가입 화면
- 로그인 및 회원가입 기능 제공
- `UserDefaults`를 통한 회원 정보 저장
  
#### 홈 화면
- 상영 중인 영화와 인기 영화 열람 가능
- 영화 클릭 시 상세 화면으로 이동

#### 검색 화면
- 영화 검색 기능 제공
- 영화 클릭 시 상세 화면으로 이동

#### 마이페이지 화면
- 회원 정보 제공
- 예매 내역을 확인할 수 있음
  
#### 상세 화면
- 영화 상세 정보 제공
- 예매하기 버튼 클릭 시 예매 화면으로 이동
  
#### 예매 화면
- 영화 예매 기능 제공, 회원 정보에 예매 내역 저장
- 예매 성공 시 홈 또는 마이페이지 화면으로 이동

## ✨ Considerations
#### 회원/비회원 플로우
- 회원 정보 유무 여부에 따라 다른 플로우를 제공
- 예매 기능은 회원 정보를 통해 접근 가능하며, 예매 정보도 회원 정보와 함께 관리됨

#### UI/UX 관련
- 로그인/회원가입 화면은 키보드 패널이 주요 컴포넌트를 가리지 않도록 설계
- 홈 화면의 검색 바를 클릭하면 검색 화면으로 이동하도록 설계


## 📦 How to Install  
1. Clone this repository:  
   ```bash  
   git clone https://github.com/SpartaCoding-iOS05-2DongJin/FlyingPopcorn.git  
   ```  
