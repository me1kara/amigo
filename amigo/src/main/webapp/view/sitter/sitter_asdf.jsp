<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>User Profile</title>
</head>
<body>
  <h1>User Profile</h1>
  <table>
    <tr>
      <td>Name:</td>
      <td>
        <c:out value="${user.name}"/>
      </td>
    </tr>
    <tr>
      <td>Email:</td>
      <td>
        <c:out value="${user.email}"/>
      </td>
    </tr>
    <tr>
      <td>Profile Picture:</td>
      <td>
        <c:choose>
          <c:when test="${not empty user.profilePicture}">
            <img src="${user.profilePicture}" alt="Profile Picture"/>
          </c:when>
          <c:otherwise>
            Profile picture not available.
          </c:otherwise>
        </c:choose>
      </td>
    </tr>
  </table>
</body>
</html>