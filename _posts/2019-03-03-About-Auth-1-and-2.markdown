---
title: "About OAuth 1.0 and 2.0"
layout: post
date: 2018-03-03 10:44
image: /assets/images/markdown.jpg
headerImage: false
tag:
- OAuth1.0
- OAuth2.0
star: true
category: blog
author: Dokeun Oh
description: About OAuth 1.0 and 2.0
---
# OAuth 1.0 and 2.0

## OAuth 1.0

OAuth (or Open Authorization) is a framework that gives users the ability to grant access to their information stored in one place, from another place.

3-legged OAuth

### OAuth vs login
    - Oauth is like someone enter company with Visitation(방문증).
    - Login is like company employee enters company building .
- OAuth is not only Authentication(인증) but also including authorization(허가).
- Open id vs OAuth
    - OpenId main purpose is Authentication like login.
    - OAuth main purpose is Authorization.
- OAuth Dance
    - OAuth Dance is User authentication process using OAuth

### OAuth representative term
    - User
        - User wants to use the Consumer with having account in the Service Provider
    - Service Provider
        - Service that provide Open API using OAuth 
    - Consumer
        - Application or web service that want to use features of the Service Provider with OAuth authentication.
    - Request Token
        - Value that the Consumer uses to authenticate access to Service provider
        - After authentication is completed, it is exchanged with Access Token.
    - Access Token 
        - After authentication, value containing the key for the Consumer access the resource of the Service provider
        - Like visiting card

### OAuth authentication process
    1. Request and issue of Request Token
    2. Invoke user authentication page. 
    3. Complete user login
    4. Request and accept permissions of user
    5. Issue Access Token
    6. Request service information using Access Token.


1. 컨슈머가 아이디/패스워드를 가지지 않고 API를 사용할 수 있음
2. 필요한 API에만 제한적으로 접근할 수 있도록 권한 제어 가능
3. 사용자가 서비스 프로바이더의 관리 페이지에서 권한 취소 가능
4. 패스워드 변경 시에도 인증 토큰은 계속 유효함.

## OAuth 2.0

### Oauth2.0 representative term
    - Roles
    - Grant types
    - Access tokens
    - Refresh token

#### Roles
    - Resource Owner
        - User
    - Resource Server 
        - Rest API Server
    - Authorization Server
        - Authorization Server(can be as same as API Server)
    - Client
        - 3-party application(Service)

#### OAuth 2.0 characteristic.
    - Reinforce application support, not web application.
    - No encryption is required. Use HTTPS, Don’t use HMAC
    - Signature simplification alignment and URL encoding is not required.
    - OAuth 2.0 allows you to specify the life-time of an access token for enhancing security
    - Very simple and Intuitive(직관적)
        - URL encoding is not required
        - Possible to create and request without Signature
        - HTTPS is required.
    - Support further more authentication method
    - Support extension of huge service
        - possible to detach or multiplex authentication servers

#### Grant types
    - Authorization code 
        - 웹 서버에서 API를 호출하는 등의 시나리오에서 Confidential Client가 사용하는 방식이다. 서버사이드 코드가 필요한 인증 방식이며 인증 과정에서 client_secret 이 필요하다. 로그인시에 페이지 URL에 response_type=code 라고 넘긴다.
    - implicit
        - token과 scope에 대한 스펙 등은 다르지만 OAuth 1.0a과 가장 비슷한 인증방식이다. Public Client인 브라우저 기반의 어플리케이션(Javascript application)이나 모바일 어플리케이션에서 이 방식을 사용하면 된다. Client 증명서를 사용할 필요가 없으며 실제로 OAuth 2.0에서 가장 많이 사용되는 방식이다. 로그인시에 페이지 URL에 response_type=token 라고 넘긴다.
    - Password 
        - 이 방식은 2-legged 방식의 인증이다. Client에 아이디/패스워드를 저장해 놓고 아이디/패스워드로 직접 access token을 받아오는 방식이다. Client 를 믿을 수 없을 때에는 사용하기에 위험하기 때문에 API 서비스의 공식 어플리케이션이나 믿을 수 있는 Client에 한해서만 사용하는 것을 추천한다. 로그인시에 API에 POST로 grant_type=password 라고 넘긴다.
    - Client credentials
        - 어플리케이션 이 Confidential Client일 때 id와 secret을 가지고 인증하는 방식이다. 로그인시에 API에 POST로 grant_type=client_credentials 라고 넘긴다
    - Device code
    - Refresh token
    - Extension

#### Access tokens
    - Access tokens represent your authorization to access the resource owner’s information on the resource server.
    - You’re required to exchange your grant for an access token, which will have an expiry time

#### Refresh Tokens
    - Refresh tokens are a special type of token that can be held securely by the client with the express purpose of being able to request a new access token from the authorization server once the original access token has expired. These can also expired, but are generally long live with expiry time that can be as long as 14 days or more


## Reference 
- https://d2.naver.com/helloworld/24942
- http://bcho.tistory.com/942
- https://earlybird.kr/1584
- https://oauth.net/2/
- http://blog.weirdx.io/post/39955
- https://opentutorials.org/course/2473/16571
