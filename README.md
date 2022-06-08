#  Team11_ Airbnb clone App

## 📑 Summarized 
### 🤼‍♂️ Member (iOS / BackEnd)
|  | 닉네임 | github ID | MBTI |
| --- | --- | --- | --- |
| **IOS** | 솔 | [Hansolkkim](https://github.com/Hansolkkim) | ISFJ |
|  | 푸코 | [wnsxor1993](https://github.com/wnsxor1993) | INTP |
| **BE** | 필 | [PhilSoGooood](https://github.com/PhilSoGooood) | ENFP |
|  | 민지노 | [Minzino](https://github.com/Minzino) | ESFJ |

### 🏆 Purpose
#### 기존 Airbnb와 유사한 기능과 화면을 구현하는 클론 앱을 만들고자 합니다. 


## ✍️ Description 
<details>
<summary><span style="font-size:150%"> 🧑‍💻 iOS </summary></span>
<div markdown="1">

### 🔥 iOS's Purpose
- **MVC 패턴을 기반으로 최대한 많은 화면과 기능을 구현하는 것과 전부 코드로 작성하는 것을 목표로 작업 진행**

### 📋 Main Work
- AlamoFire를 이용한 네트워킹
- MapKit을 활용하여 장소 자동 서칭 기능 구현
- CLLocation을 통해 사용자 위치 정보 권한 요청 및 데이터 가공 기능 구현
- Custom CalendarView 구현
- CompositionalLayout 활용 및 dataSource 로직 분리
    
### 💾 DailyScrum
[노션 링크_ 일별 작업 진행 사항](https://sticky-pajama-dc0.notion.site/099e80f32cd741388309c0ad2b6c20b4?v=bcc2b7f8465d4159b0f8ebc9fe26018f)

### 📝 Summary
1. HomeView
    - CLLocation을 통해 사용자 위치 권한 요청 및 정보 데이터 관리 기능 구현
        - 위치 권한 denied 시, Alert를 띄워 설정창으로 이동할 수 있게 구현
        - 사용자 위치 정보 데이터 관리 객체 구현
    - 한 화면에 여러 CollectionView가 필요하여 `UICollectionViewCompositionalLayout`을 활용하여 화면 구성
    - UISearchBar를 button 형태로 활용
    
2. BrowseView
    - UISearchController를 통해 searchBar 구현
        - 화면 전환 시, searchBar를 firstResponder로 지정하여 키보드가 바로 출력되도록 구현
    - Mapkit을 활용하여 장소에 대한 자동 서칭 기능 구현
        - 기존 화면은 자동으로 인기 장소를 보여주는 화면이나, 서칭 시에 자동 서칭 화면으로 전환되도록 구현
        - MKLocalSearchCompleter와 Completion 배열을 관리하는 manager 객체를 분리


3. DecidingOptionsView
    - Custom CalendarView를 구현하여 체크인/ 체크아웃 날짜를 선택할 수 있는 기능 구현
    - Delegate 패턴을 이용해 View와 Controller, UseCase 간 데이터를 주고 받도록 구현

4. AccomodationsView
    - 이전 화면에서 선택한 Option들을 넘겨받아 화면을 구성하도록 구현
    
5. DetailPageView
    - dataSource가 VC의 코드와 분리되어 있는 상태에서 Cell 내부의 프로퍼티의 액션을 연결하기 위해 delegate 활용
    - Custom ToolBar 구현
        - 단순 button이 아닌, customView를 UIBarButtonItem으로 할당

|HomeView|BrowseView1(검색전)|BrowseView2(검색후)|
|---|---|---|
|<img src="https://user-images.githubusercontent.com/92504186/172555626-c3f1d257-bc19-47da-930d-7a795e694590.jpg" alt="SS 2022-06-08 PM 03 33 54" width="100%;" />|<img src="https://user-images.githubusercontent.com/92504186/172573654-15bbfb5d-bb00-453d-adf8-bce7037b0fda.jpg" alt="SS 2022-06-08 PM 05 46 10" width="100%;" />|<img src="https://user-images.githubusercontent.com/92504186/172573807-5c3be300-06ea-410d-8934-f920ee5f3f0a.jpg" alt="SS 2022-06-08 PM 05 47 14" width="100%;" />|

|DecidingOptionsView(CalendarView)|Accomodations|DetailPageView|
<!-- |---|---|---| -->
|<img src="https://user-images.githubusercontent.com/92504186/172574209-9566550c-0f08-4e2a-87d1-aeaf3b169ccc.jpg" alt="SS 2022-06-08 PM 05 49 25" width="100%;" />|<img src="https://user-images.githubusercontent.com/92504186/172556620-44cdc920-a530-4112-9d0e-28bde42f9e2a.jpg" alt="SS 2022-06-08 PM 04 23 32" width="100%;" />|<img src="https://user-images.githubusercontent.com/92504186/172555940-a2d45376-1fb1-4910-814d-d0ea011b68a5.jpg" alt="SS 2022-06-08 PM 04 20 19" width="100%;" />|

</div>
</details>

<details>
<summary><span style="font-size:150%"> 🧑‍💻 Backend </summary></span>
<div markdown="1">
BE분들 내용은 여기다가 작성하시면 됩니다!

</div>
</details>

