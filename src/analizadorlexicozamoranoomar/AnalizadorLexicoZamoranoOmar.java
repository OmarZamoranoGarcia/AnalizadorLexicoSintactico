/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Main.java to edit this template
 */
package analizadorlexicozamoranoomar;

import java.io.File;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import jflex.exceptions.SilentExit;
import java.nio.file.*;

/**
 *
 * @author Usuario
 */
public class AnalizadorLexicoZamoranoOmar {

    public static void main(String[] args) throws SilentExit, Exception {
        // Rutas para los archivos .flex y .cup
        String rutaLexicoFlex = "C:/Users/Usuario/Documents/Analizador-Lexico-master/src/analizadorlexicozamoranoomar/codJFlex.flex";
        String rutaLexicoCup = "C:/Users/Usuario/Documents/Analizador-Lexico-master/src/analizadorlexicozamoranoomar/LexerCUP.flex";
        String[] rutaSintacticoCup = {
            "-parser", 
            "Sintax", 
            "C:/Users/Usuario/Documents/Analizador-Lexico-master/src/analizadorlexicozamoranoomar/Sintax.cup"
        };

        // Generar analizador léxico (JFlex)
        //GenerarAnalizadorLexico(rutaLexicoFlex);  // Genera Lexer.java (analizador léxico base)
        GenerarAnalizadorLexico(rutaLexicoCup);   // Genera LexerCUP.java (compatible con CUP)

        // Generar analizador sintáctico (CUP)
        GenerarAnalizadorSintactico(rutaSintacticoCup);
    }

    public static void GenerarAnalizadorLexico(String ruta) throws SilentExit {  
        String[] opcionesFlex = { ruta };
        jflex.Main.generate(opcionesFlex);
    }

    public static void GenerarAnalizadorSintactico(String[] rutasCUP) throws Exception {
        // Ejecuta CUP para generar Sintax.java y sym.java
        java_cup.Main.main(rutasCUP);

        // Mueve los archivos generados a la carpeta correcta
        Path rutaSym = Paths.get("C:/Users/Usuario/Documents/Analizador-Lexico-master/src/analizadorlexicozamoranoomar/sym.java");
        Path rutaSintax = Paths.get("C:/Users/Usuario/Documents/Analizador-Lexico-master/src/analizadorlexicozamoranoomar/Sintax.java");

        // Elimina archivos antiguos si existen
        Files.deleteIfExists(rutaSym);
        Files.deleteIfExists(rutaSintax);

        // Mueve los nuevos archivos generados
        Files.move(
            Paths.get("sym.java"), 
            rutaSym, 
            StandardCopyOption.REPLACE_EXISTING
        );
        Files.move(
            Paths.get("Sintax.java"), 
            rutaSintax, 
            StandardCopyOption.REPLACE_EXISTING
        );
    }
}