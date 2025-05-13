package analizadorlexicozamoranoomar;
import java_cup.runtime.Symbol; 
%%
%class LexerCUP
%public 
%line 
%char 
%cup 
%unicode

%init{ 
    yyline = 1; 
    yychar = 1; 
%init} 

L=[a-zA-Z_]+
D = [0-9]+
NUMDECIMAL = {D}"."{D}+   
NUMEROS= {D} | {NUMDECIMAL}
espacio=[ \t\r]+
LITERAL = \"([^\"\\]|\\.)*\" 

%%
print {return new Symbol(sym.Imprime, yychar, yyline, yytext());}
external | public | extern | protected | private | static | virtual | override | pub | mut | reified {return new Symbol(sym.Modificador_de_acceso, yychar, yyline, yytext());}
object | boolean | DWORD | unsigned | QWORD | float | WORD | var | TBYTE | FWORD | string | byte | char | long | const | enum | double | let | BYTE | int | decimal | bit | nchar | complex | persistent {return new Symbol(sym.Tipo_de_dato, yychar, yyline, yytext());} 
return {return new Symbol(sym.Devuelve_valor, yychar, yyline, yytext());}
= | set | SET {return new Symbol(sym.Asigna, yychar, yyline, yytext());}
main {return new Symbol(sym.Principal, yychar, yyline, yytext());}
method {return new Symbol(sym.Declarador_de_metodos, yychar, yyline, yytext());}
class {return new Symbol(sym.Crear_clase, yychar, yyline, yytext());}
do | while | for | loop | parfor {return new Symbol(sym.Bucles, yychar, yyline, yytext());}
{espacio} {/*Ignore*/}
"//".* {/*Ignore*/}
\n {yychar=1;}
"<" | ">" | "==" | "<=" | ">=" {return new Symbol(sym.Operador_comparativo, yychar, yyline, yytext());}
"}" {return new Symbol(sym.Llave_Der, yychar, yyline, yytext());}
"{" {return new Symbol(sym.Llave_Izq, yychar, yyline, yytext());}
")" {return new Symbol(sym.Parentesis_Der, yychar, yyline, yytext());}
"(" {return new Symbol(sym.Parentesis_Izq, yychar, yyline, yytext());}
";" {return new Symbol(sym.PuntoComa, yychar, yyline, yytext());}
"," {return new Symbol(sym.Coma, yychar, yyline, yytext());}
"]" {return new Symbol(sym.Corchete_Der, yychar, yyline, yytext());}
"[" {return new Symbol(sym.Corchete_Izq, yychar, yyline, yytext());}
{L}({L}|{D})* {return new Symbol(sym.Identificador, yychar, yyline, yytext());}
"-"?{NUMEROS} {return new Symbol(sym.Numero, yychar, yyline, yytext());}
{LITERAL} {return new Symbol(sym.Literal, yyline, yycolumn, yytext().substring(1, yytext().length()-1));}
. {
    System.out.println("Este es un error lexico: "+yytext()+
    ", en la linea: "+yyline+", en la columna: "+yychar);
}

