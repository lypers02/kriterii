program pr1;
Label
  m_1, m_2;
Var 
  a,b: array of array of real;
  sum, sred: array of real;
  i,j,n:word;
  s:string;
  p:integer;
Begin
m_2:write('Введите количество критериев  n = '); 
   readln(s);                                             // Ввод количества критериев
   val(s,n,p);                                            // Контроль ввода числа
   if p<>0  then  begin write ('Ошибка, повторите ввод!'); goto m_2 end;
   if n<=0 then begin writeln('Oшибка, повторите ввод!'); goto m_2 end else   
begin
  SetLength(a,n+1);SetLength(b,n+1);                      // Установка размерности динамических массивов
  For i:=1 to n do 
    begin
      Setlength(a[i],n+1);
      SetLength(b[i],n+1);
    end;
  SetLength(sum,n+1); SetLength(sred,n+1);
  writeln('Введите элементы матрицы попарных сравнений, расположенные над главной диагональю');
  for i:=1 to n-1 do                                      // Заполнение матрицы А попарных сравнений
  for j:=i+1 to n do
  begin
    m_1: write('Отношение критерия ', i, ' к критерию ',j,' = ');
      readln(a[i,j]);
          if (a[i,j]<=0) or (a[i,j]>9) then              // Контроль ввода числа из заданного МАИ интервала
             begin 
               writeln ('Ошибка! Повторите ввод');
               goto m_1 
             end;
  end;
  a[1,1]:=1;
  for j:=1 to n-1 do 
  for i:=j+1 to n do
     begin
       a[i,i]:=1;
       a[i,j]:=1/a[j,i]
     end;
  writeln;
  writeln ('Матрица попарных сравнений имеет вид:');
  for i:=1 to n do 
     begin
       for j:=1 to n do write(a[i,j]:8:3);
       writeln;
     end;
  for j := 1 to n do sum[j]:= 0;               // Вычисление сумм столбцов матрицы
  for i := 1 to n do                           // Заполнение матрицы В делением каждого элемента матрицы А на сумму столбца
     begin
       for j := 1 to n do sum[j] := sum[j] + a[i, j];     
      end;
  for i := 1 to n do 
     begin
       for j := 1 to n do b[i,j]:= a[i,j]/sum[j] 
     end;
  for i:=1 to n do                             // Вычисление среднего арифметического каждой строки матрицы В
     begin
        sum[i] := 0;
        for j:= 1 to n do sum[i]:=sum[i]+b[i,j];
        sred[i]:=sum[i]/n; 
     end;
     writeln;
     writeln ('Весовой столбец критериев по цели имеет вид:');
  for i:=1 to n do writeln('Вес критерия ', i, ' равен ',sred[i]:2:3, ' ');  
end;
End.
  