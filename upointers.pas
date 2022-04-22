unit upointers;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  r_user=record
    dname:string[255];
    dpassword:string[255];
  end;

  pr_user = ^r_user;

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;
  a:integer;
  b:real;
  p_a:pointer;
  p_i_a:^integer;
  p_b:pointer;

  kd:pointer;

  dude:pr_user;

  b_arr:array of integer;
  ap:pointer;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
var i:integer;
begin

  randomize;

  a:=strtoint(edit1.text);
  p_a:=@a;  //p_a:=Addr(a);
  p_i_a:=@a;//p_i_a:=Addr(a);

  b:=strtofloat(edit2.text);
  p_b:=@b;

  GetMem(kd,{пишемо 3 integer}3*SizeOf(integer));
  integer(kd^):=strtoint(edit3.text);
  inc(kd,SizeOf(integer)); //зміщуємось на 1 integer
  integer(kd^):=strtoint(edit4.text);
  inc(kd,SizeOf(integer)); //зміщуємось на 1 integer
  integer(kd^):=strtoint(edit5.text);
  dec(kd,2*SizeOf(integer));//зміщуємось назад на 2 integer

  //виділяємо пам'ять під запис
  new(dude); //dude:=new(pr_user);

  dude^.dname:=edit6.Text;
  dude^.dpassword:=edit7.Text;

  setlength(b_arr,5);

  ap:=@b_arr[low(b_arr)];

  for i:=low(b_arr) to high(b_arr) do
  begin
    integer(ap^):=random(10);
    inc(ap,sizeof(integer));
  end;

  Memo1.Clear;
  Memo1.Lines.Add('a='+inttostr(a));
  Memo1.Lines.Add('p_a='+inttostr(integer(p_a)));
  //Не зпрацює: Memo1.Lines.Add('p_a^='+inttostr(p_a^));
  Memo1.Lines.Add('integer(p_a^)='+inttostr(integer(p_a^)));
  Memo1.Lines.Add('p_i_a^='+inttostr(p_i_a^));

  Memo1.Lines.Add('real(p_b^)='+floattostr(real(p_b^)));
  Memo1.Lines.Add('integer(p_b^)='+inttostr(integer(p_b^)));

  Memo1.Lines.Add('1) integer(kd^)='+inttostr(integer(kd^)));
  inc(kd,sizeof(integer));
  Memo1.Lines.Add('2) integer(kd^)='+inttostr(integer(kd^)));
  inc(kd,sizeof(integer));
  Memo1.Lines.Add('3) integer(kd^)='+inttostr(integer(kd^)));
  dec(kd,2*sizeof(integer));

  Memo1.Lines.Add('Dude data: name - '+dude^.dname+'; pass - '+dude^.dpassword+';');

  for i:=low(b_arr) to high(b_arr) do
    Memo1.Lines.Add('b_arr #'+inttostr(i)+'='+inttostr(b_arr[i]));

  //звільнюємо пам'ять
  FreeMem(kd);
  Dispose(dude);

end;

end.

