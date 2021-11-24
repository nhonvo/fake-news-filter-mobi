class LoginModel {
/*
{
  "userId": "69db714f-9576-45ba-b5b7-f00649be00de",
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy91cmkiOiJkZWZhdWx0LnBuZyIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL2VtYWlsYWRkcmVzcyI6ImJwLmtodXllbkBodXRlY2guZWR1LnZuIiwiaHR0cDovL3NjaGVtYXMueG1sc29hcC5vcmcvd3MvMjAwNS8wNS9pZGVudGl0eS9jbGFpbXMvZ2l2ZW5uYW1lIjoiQnVpIFBodSBLaHV5ZW4iLCJodHRwOi8vc2NoZW1hcy5taWNyb3NvZnQuY29tL3dzLzIwMDgvMDYvaWRlbnRpdHkvY2xhaW1zL3JvbGUiOiJBZG1pbiIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL25hbWUiOiJraHV5ZW5wYiIsImV4cCI6MTYzNzYwMzI0MCwiaXNzIjoiaHR0cDovL2xvY2FsaG9zdDo1MDAxIiwiYXVkIjoiaHR0cDovL2xvY2FsaG9zdDo1MDAxIn0.N8LeirjWH9WZ85GoCEBu2i-mtwwARcwG1N-LwXMO5dg"
}
*/

  String? userId;
  String? token;

  LoginModel({
    this.userId,
    this.token,
  });
  LoginModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId']?.toString();
    token = json['token']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['userId'] = userId;
    data['token'] = token;
    return data;
  }
}
