### 2. 서버가 시작하는 시점에 부모 ApplicationContext와 자식 ApplicationContext가 초기화되는 과정에 대해 구체적으로 설명해라.

```
<listener>
	<listener-class>org.springframework.web.context.ContextLoaderListener</listener-class>
</listener>
<context-param>
	<param-name>contextConfigLocation</param-name>
	<param-value>
		classpath:/applicationContext.xml
	</param-value>
</context-param>
```
spring에 contextLoaderListener 가 있다
그 클래스는 parameter로 contextConfigLocation 에 값을 읽어 applicationContext.xml을 불러와 실행한다.   
이렇게 하면 부모가 생성 된다  
classpath:/applicationContext.xml 가 부모 이다.
```
<servlet>
	<servlet-name>next</servlet-name>
	<servlet-class>org.springframework.web.servlet.DispatcherServlet</servlet-class>
</servlet>

<servlet-mapping>
	<servlet-name>next</servlet-name>
	<url-pattern>/</url-pattern>
</servlet-mapping>
```
사용자가 ('/')에 접근할때 dispatcherServlet 이 실행된다
next-servlet.xml을 찾아서 실행한다
이렇게 하면 자식이 생성 된다   
next-servlet.xml 이 자식이 된다
bean을 찾을때 자식에서 먼저 찾고 없으면 부모에서 찾는다  
따라서 같은 빈을 가지고 있어도 자식이 우선이 된다  
부모는 여러 자식을 가질 수 있다  

왜쓸까?
전체 어플리케이션에서 웹 기술에 의존적인 부분과 그렇지 않은 부분을 구분하기 위해서이다.     

### 3. 서버 시작 후 http://localhost:8080으로 접근해서 질문 목록이 보이기까지 흐름에 대해 최대한 구체적으로 설명하라. 
* 
```
http://localhost:8080으로 접근하면 dispatcherServlet 이 시작된다
dispatcherServlet 은 next-servlet.xml 을 실행시키고
<mvc:annotation-driven />에 따라 @Controller가 붙은 클래스를 controller 빈으로 등록하고
@Controller 에서 url에 매핑되는 메소드를 실행 시킨다.

메소드에 parameter 는 타입에 따라 새로운 객체를 생성하고 
새로운 객체의 set'변수'() 메소드에 '변수'랑 매핑되는 request.parameter값을 넣어준다

객체의 parameter 중 model은 response처럼 add.Attribute하면 
return 값에 매핑되는 jsp를 찾고 attribute를 매핑해서 클라이언트에게 준다
```

### 9. UserService와 QnaService 중 multi thread에서 문제가 발생할 가능성이 있는 소스는 무엇이며, 그 이유는 무엇인가?
* 
```
singleton : 하나의 빈정의가 스프링 ioC 컨테이너마다 하나의 객체 인스턴스가 되는 범위
prototype : 하나의 빈정의가 다수의 객체 인스턴스가 되는 범위를 말한다
따라서 @Scope("prototype") 이렇게 설정해야 Service Class 가 하나의 인스턴스가 아닌 여러개의 인스턴스를 만드므로
동시 접근했을때 문제가 생기지 않는다.
```
