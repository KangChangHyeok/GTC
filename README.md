# 그릿지 테스트 챌린지(instagram Clone Project)
> 시연영상 구글드라이브 링크 https://drive.google.com/file/d/1ZH75TFQMKOiOsa8TCm43i2aTPpiJgyIN/view?usp=sharing

## 프로젝트 소개
- instagram Clone Project입니다.

## 기술 스택
### Swift
- Swift 5
- UIKit
### 뷰 드로잉
- Interface builder : Storyboard
### 백엔드
- Swagger UI 기반의 서버 활용
- Kakao Auth
- Local DB: UserDefault
### 네트워킹
- Alamofire
### 개발 아키텍처 및 디자인 패턴
- MVC
### 이외에 사용한 오픈소스
- Kingfisher
- DLRadioButton
## 기능
- 회원가입 기능 구현 완료했습니다.

### 회원가입 기능
가입 절차에 따라 회원가입을 진행합니다.
- 각각 절차마다 UserDefault를 활용하여 정보를 저장합니다.
- 자체 회원가입과 소셜 로그인이 각각 요구하는 데이터가 다르기 때문에 enum타입을 사용해 구분지어 분기처리를 하였습니다.

<details>
<summary>코드 보기</summary>
<div markdown="1">

```swift
@IBAction func nextButtonTapped(_ sender: UIButton) {
        let dataManger = DataManager()
        //자체 회원가입으로 진행할때
        if UserSignUpInfo.shared.loginPattern == .normal {
            dataManger.postUserSignUp { UserPostResponse in
                print(UserPostResponse)
                let mainTabBarController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainTabBarController") as! MainTabBarController
                self.view.window?.rootViewController = mainTabBarController
            }
        // 소셜 로그인으로 가입할때(loginPattern = .kakao)
        } else {
            dataManger.postKakaoUserSignUp(accessToken: UserSignUpInfo.shared.accessToken) { UserPostResponse in
                print("소셜 로그인 회원가입 성공!")
                print(UserPostResponse)
                let mainTabBarController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainTabBarController") as! MainTabBarController
                self.view.window?.rootViewController = mainTabBarController
            }
        }
    }
```

</div>
</details>

## 프로젝트를 통해 배운것

### 소셜 로그인 구현
처음으로 소셜 로그인을 연동하여 구현해 보았습니다.  
어려울 것이라 생각했는데, 자체적으로 구현이 매우 잘 되있어서 토큰값과 유저 정보를 활용하여 로그인 기능을 구현하였습니다.  
로그인이 성공했을 경우와 실패했을 경우 각각 분기처리하였습니다.

<details>
<summary>코드 보기</summary>
<div markdown="1">

```swift
    @IBAction func KakaoLoginButtonTapped(_ sender: UIButton) {
        UserSignUpInfo.shared.loginPattern = .kakao
        UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
            //로그인 실패했을때
            guard let accessToken = oauthToken?.accessToken else {return}
            if let error = error {
                print("로그인 실패", error)
                let kakaoLoginFailAlert = UIAlertController(title: "로그인에 실패하였습니다.", message: nil, preferredStyle: .alert)
                kakaoLoginFailAlert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
                self.present(kakaoLoginFailAlert, animated: true)
            }
            //로그인 성공했을때
            else {
                print("카카오 로그인 성공")
                self.dataManager.postUserKakaoSignIn(accessToken: accessToken) { UserPostResponse in
                    //성공
                    if UserPostResponse.isSuccess == true {
                        //성공시
                        
                        UserDefaults.standard.setValue(UserPostResponse.result?.jwt, forKey: "jwt")
                        let mainViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainTabBarController") as! MainTabBarController
                        self.view.window?.rootViewController = mainViewController
                        
                        
                        
                    } else {
                        //카카오 로그인은 정상적으로 성공했으나, 인스타그램 아이디를 생성하지 않았을때.
                        UserSignUpInfo.shared.accessToken = accessToken
                        var kakaoUserId = ""
                        UserApi.shared.me { user, error in
                            if let result = user?.kakaoAccount?.email {
                                kakaoUserId = result
                            }
                            let sheet = UIAlertController(title: "계정을 찾을 수 없음", message: "\(kakaoUserId)에 연결된 계정을 찾을 수 없습니다. 다른 전화번호나 이메일 주소를 사용해보세요. Instagram 계정이 없으면 가입할 수 있습니다.", preferredStyle: .alert)
                            
                            sheet.addAction(UIAlertAction(title: "가입하기", style: .default, handler: { UIAlertAction in
                                let emailJoinViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EmailJoinViewController") as! EmailJoinViewController
                                emailJoinViewController.modalPresentationStyle = .fullScreen
                                self.present(emailJoinViewController, animated: false)
                            }))
                            sheet.addAction(UIAlertAction(title: "다시 시도", style: .default))
                            self.present(sheet, animated: true)
                        }
                    }
                }
            }
        }
    }
```

</div>
</details>

### Dateformater 
회원가입 절차중 유저의 생년월일을 활용하기 위해 dateformater를 활용하여 서버에 보낼 데이터 형식으로 맞추었습니다.  

<details>
<summary>코드 보기</summary>
<div markdown="1">

```swift
    @IBAction func changeUserBirthDay(_ sender: UIDatePicker) {
        userBirthDay.textColor = .black
        // 유저 나이 구하기
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy"
        let userBirth = Int(dateformatter.string(from: sender.date))!
        let now = Int(dateformatter.string(from: Date()))!
        userAge.text = (now - userBirth + 1).description + "세"
        // 유저 생일 표시하기
        dateformatter.dateFormat = "yyyy년 MM월 dd일"
        userBirthDay.text = dateformatter.string(from: sender.date)
        dateformatter.dateFormat = "yyyy.MM.dd"
        UserSignUpInfo.shared.userBirthday = dateformatter.string(from: sender.date)
        // 오늘 이후 날짜 선택시 버튼 비활성화
        dateformatter.dateFormat = "yyyyMMdd"
        let nowYear = Int(dateformatter.string(from: Date()))!
        let selectYear = Int(dateformatter.string(from: sender.date))!
        if nowYear - selectYear < 0 {
            nextButton.isEnabled = false
            nextButton.alpha = 0.5
            userAge.text = ""
        }
    }
```

</div>
</details>
