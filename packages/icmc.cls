%%
%% Customizacoes do abnTeX2 (http://abnTeX2.googlecode.com) para o 
%% Instituto de Ciencias Matematicas e de Computacao, Universidade 
%% de Sao Paulo
%%
%% This work may be distributed and/or modified under the
%% conditions of the LaTeX Project Public License, either version 1.3
%% of this license or (at your option) any later version.
%% The latest version of this license is in
%%   http://www.latex-project.org/lppl.txt
%% and version 1.3 or later is part of all distributions of LaTeX
%% version 2005/12/01 or later.
%%
%% This work has the LPPL maintenance status `maintained'.
%% 
%% The Current Maintainer of this work is Humberto Lidio Antonelli, 
%% Contact: humbertoantonelli@usp.br
%%
%% Further information about abnTeX2 are available on 
%% http://abntex2.googlecode.com/
%%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{packages/icmc}[2021/08/11 v1.4.1 Classe ICMC baseado em abnTeX2 - Teses e Dissertacoes dos Programas de Pos-graduacao do Instituto de Ciencias Matematicas e de Computacao]
\RequirePackage{xifthen}
\RequirePackage{ifxetex}        % Verifica se a compilacao ocorre por xetex
\RequirePackage{ifluatex}       % Verifica se a compilacao ocorre por luatex

%================================================================================
% Declaracao de opcoes
%================================================================================
% Opcoes:
% 	qualificacao:   Formata documento para qualificacao
%	doutorado:      Formata documento para tese de doutorado
% 	mestrado:       Formata documento para dissertacao de mestrado
% 	pre-defesa:     Formata documento para versao de defesa (utilizado apenas para versao completa)
%   pro-defesa:     Formata documento para versao final (utilizado apenas para versao completa)
%   impressao:      Formata documento para versao de impressao
% -------------------------------------------------------------------------------

\DeclareOption*{%
    \PackageWarning{icmc}{Unknown option ‘\CurrentOption’}%
}

\newboolean{opt-qualificacao}
\setboolean{opt-qualificacao}{false}
\DeclareOption{qualificacao}{
    \setboolean{opt-qualificacao}{true}
}

\newboolean{opt-doutorado}
\DeclareOption{doutorado}{
    \setboolean{opt-doutorado}{true}
}
\DeclareOption{mestrado}{
    \setboolean{opt-doutorado}{false}
}
\ExecuteOptions{doutorado}

\newboolean{opt-pre-defesa}
\DeclareOption{pre-defesa}{
    \setboolean{opt-pre-defesa}{true}
}
\DeclareOption{pos-defesa}{
    \setboolean{opt-pre-defesa}{false}
}
\ExecuteOptions{pos-defesa}

\newboolean{opt-impressao}
\setboolean{opt-impressao}{false}
\newcommand{\colorlinks}{true}
\DeclareOption{impressao}{
    \setboolean{opt-impressao}{true}
    \renewcommand{\colorlinks}{false}
}

% Repassa demais opcoes a abntex	
\DeclareOption*{%
  \PassOptionsToClass{\CurrentOption}{abntex2}%
}

% Repassa os tres idiomas principais para o pacote Babel
\PassOptionsToPackage{spanish, english, brazil}{babel}

\ProcessOptions\relax


%================================================================================
% Heranca da classe `abntex2' e inclusao de pacotes e arquivos necessarios
%================================================================================
\LoadClass[% -- opcoes da classe memoir --
	12pt,				% tamanho da fonte
	openright,			% capitulos comecam em pagina impar (insere pagina vazia caso preciso)
	twoside,			% para impressao em verso e anverso. Oposto a oneside
	a4paper,			% tamanho do papel. 
	chapter=TITLE		% titulos de capitulos convertidos em letras maiusculas
	]{abntex2}
	

%================================================================================
% Pacotes fundamentais 
%================================================================================
\RequirePackage{morewrites}     % Resolve o erro “No room for a new \write”
\RequirePackage{cmap}			% Mapear caracteres especiais no PDF
\RequirePackage{lmodern}		% Usa a fonte Latin Modern.
\RequirePackage{lastpage}		% Usado pela Ficha catalografica
\RequirePackage{indentfirst}	% Indenta o primeiro paragrafo de cada secao.
\RequirePackage{color, xcolor}  % Controle das cores
\RequirePackage{colortbl}       % Controle das cores das celulas da tabela(utilizado no titulo)
\RequirePackage{graphicx}		% Inclusao de graficos
\RequirePackage{caption}        % Pacote para definicao dos captions
\RequirePackage{subcaption}     % Pacote para definicao dos subcaptions(ambientes de subfigures)
\RequirePackage{microtype} 		% para melhorias de justificacao
\RequirePackage{pdfpages}       % Inclusao de arquivos PDF
\RequirePackage{hyphenat}       % Pacote para retirar a hifenizacao do preambulo
\RequirePackage{xstring}        % Pacate para manipulacao de Strings
\RequirePackage{etoolbox}       % Pacote utilizado para armazenamento de resumos
\RequirePackage{amsthm, amsfonts, amsmath, amssymb} % Pacote para a definicao dos ambientes matematicos
\RequirePackage{mathptmx}       % Usando times para equacoes, opcional
\RequirePackage{listings}       % Pacote para formatacao de diversos codigos fontes
\RequirePackage{algorithm, algpseudocode}  % Pacote para escrever algoritmos em pseudo-codigo
\RequirePackage{nomencl}        % Pacote para criacao da Lista de Siglas
\RequirePackage[noredefwarn,translate=babel,nonumberlist,style=list,toc]{glossaries}	 % Pacote para gerar o glossario
\RequirePackage[brazilian,hyperpageref]{backref} % Paginas com as citacoes na bibl
\RequirePackage{float}          % Pacote para criacao de novos ambientes
\RequirePackage[alf,bibjustif,abnt-etal-text=it,abnt-repeated-author-omit=yes,abnt-emphasize=bf,abnt-etal-cite=3,abnt-etal-list=0]{abntex2cite}   % Citacoes padrao ABNT
\RequirePackage{environ}        % Pacote para definicao de ambientes
\RequirePackage[absolute]{textpos} % Pacote para posicionamento do texto
\RequirePackage{eso-pic}        % Pacote para incluir imagem de fundo
\RequirePackage{adjustbox}      % Pacote para ajuste do tamanho do nome do autor na capa


%================================================================================
% Comando para configuracao do tipo de trabalho
%================================================================================

\providecommand*{\tipoexemplar}{}
\providecommand*{\degree}{}
\providecommand*{\tipodocurso}{}
\providecommand*{\exam}{}
\providecommand*{\arealabel}{}

% Configuracao do texto do preambulo
\addto\captionsenglish{% ingles
    \renewcommand{\exam}{ in accordance with the requirements of the \imprimirprograma, for the}
}
\addto\captionsbrazil{% portugues-brasil
    \renewcommand{\exam}{ como parte dos requisitos para obten{\c c}{\~a}o do t{\'i}tulo de}
}

% Configuracao da situacao do trabalho entregue
\ifthenelse{\boolean{opt-pre-defesa}}{
    \addto\captionsenglish{% ingles
        \renewcommand{\tipoexemplar}{EXAMINATION BOARD PRESENTATION COPY}
    }
    \addto\captionsbrazil{% portugues-brasil
        \renewcommand{\tipoexemplar}{EXEMPLAR DE DEFESA}
    }
}{
    \addto\captionsenglish{% ingles
        \renewcommand*{\tipoexemplar}{FINAL VERSION}
    }
    \addto\captionsbrazil{% portugues-brasil
        \renewcommand{\tipoexemplar}{VERS{\~A}O REVISADA}
    }
}

% Configuracao do tipo de trabalho para DOUTORADO ou MESTRADO
\ifthenelse{\boolean{opt-doutorado}}{
    \addto\captionsenglish{% ingles
        \renewcommand{\degree}{degree of Doctor}
        \renewcommand{\tipodocurso}{Doctorate Candidate}
        \tipotrabalho{Thesis}
    }
    \addto\captionsbrazil{% portugues-brasil
        \ifthenelse{\equal{\imprimirgenero}{M}}{\renewcommand{\degree}{Doutor}}{\renewcommand{\degree}{Doutora}}
        \renewcommand{\tipodocurso}{Doutorado}
        \tipotrabalho{Tese}
    }
}{
    \addto\captionsenglish{% ingles
        \renewcommand{\degree}{degree of Master}
        \renewcommand{\tipodocurso}{Master student}
        \tipotrabalho{Dissertation}
    }
    \addto\captionsbrazil{% portugues-brasil
        \ifthenelse{\equal{\imprimirgenero}{M}}{\renewcommand{\degree}{Mestre}}{\renewcommand{\degree}{Mestra}}
        \renewcommand{\tipodocurso}{Mestrado}
        \tipotrabalho{Disserta{\c c}{\~a}o}
    }
}

% Configuracao do tipo de trabalho como QUALIFICACAO de DOUTORADO ou MESTRADO
\ifthenelse{\boolean{opt-qualificacao}}{
    \addto\captionsenglish{% ingles
        \renewcommand{\exam}{ as part of the qualifying exam requisites of the \imprimirprograma, for the}
        \tipotrabalho{Monograph}
        \renewcommand{\tipoexemplar}{}
    }
    \addto\captionsbrazil{% portugues-brasil
        \renewcommand{\exam}{ para o Exame de Qualifica{\c c}{\~a}o, como parte dos requisitos para obten{\c c}{\~a}o do t{\'i}tulo de}
        \tipotrabalho{Monografia}
        \renewcommand{\tipoexemplar}{}
    }
}{}

% Configuracao do texto impresso no Preambulo
\addto\captionsenglish{% ingles
    \renewcommand{\imprimirpreambulo}{\nohyphens{\imprimirtipotrabalho~submitted to the \imprimirinstituicao~-- \exam~\degree~\imprimirespecialidade. \textit{\tipoexemplar}}}
    \renewcommand{\arealabel}{Concentration Area}
}
\addto\captionsbrazil{% portugues-brasil
    \renewcommand{\imprimirpreambulo}{\nohyphens{\imprimirtipotrabalho~apresentada ao \imprimirinstituicao,\exam~\degree~\imprimirespecialidade. \textit{\tipoexemplar}}}
    \renewcommand{\arealabel}{{\'A}rea de Concentra{\c c}{\~a}o}
}


%================================================================================
% Comando auxiliares
%================================================================================

% Comando para marcar texto para revisao
\newcommand{\rev}[1]{\textcolor{red}{[#1]}}

% Legendas utilizadas em Figuras / Tabelas / Etc.
\newcommand{\fautor}{\legend{Fonte: Elaborada pelo autor.}}
\newcommand{\fadaptada}[2][]{\legend{Fonte: Adaptada de \citeonline[#1]{#2}.}}
\newcommand{\fdireta}[2][]{\legend{Fonte: \citeonline[#1]{#2}.}}
\newcommand{\fdadospesquisa}{\legend{Fonte: Dados da pesquisa.}}

\addto\captionsenglish{% ingles
    % Legendas utilizadas em Figuras / Tabelas / Etc.
    \renewcommand{\fautor}{\legend{Source: Elaborated by the author.}}
    \renewcommand{\fadaptada}[1]{\legend{Source: Adapted from \citeonline{#1}.}}
    \renewcommand{\fdireta}[1]{\legend{Source: \citeonline{#1}.}}
    \renewcommand{\fdadospesquisa}{\legend{Source: Research data.}}
}

% Automatiza o processo de aspas
\newcommand{\aspas}[1]{``{#1}''}

% Palavras-chave do resumo
\newcommand{\palavraschave}{}


%================================================================================
% Pacote para criacao da lista de siglas e abreviaturas
%================================================================================

% Configuracao do pacote nomencl
% Tamanho da Label da sigla
\setlength{\nomlabelwidth}{0.15\hsize} 
% Separa as abreviaturas de suas definicoes com pontos (....)
\renewcommand{\nomlabel}[1]{#1 \hfill}
\setlength{\nomitemsep}{-.05in} 
% Comando necessario para a criacao da lista de abreviaturas
\makenomenclature
% Traduz o titulo da lista de abreviaturas
\renewcommand{\nomname}{\listadesiglasname}

% Comando para criacao de abreviaturas e siglas
\def\sigla{\@ifstar\@sigla\@@sigla}
% Apenas faz o registro na tabela de siglas
\def\@sigla#1#2{\nomenclature{#1}{#2}}          % \sigla*{}{} 
% Faz o registro na tabela de siglas e insere os dados no corpo do documento
\def\@@sigla#1#2{#2 (#1)\nomenclature{#1}{#2}}  % \sigla{}{}


%================================================================================
% Pacote para criacao do GLOSSARIO
%================================================================================
% Gera o indice do Glossario
\makeglossaries
% Traduz o nome do glossario
\addto\captionsbrazil{% portugues-brasil
    \renewcommand{\glossaryname}{Gloss\'ario}
}

% Contador de definicoes do Glossario
\newcounter{count_glossario}
% Comando para simplificar a definicao de palavras no glossario
\newcommand{\newword}[2]{%
    \stepcounter{count_glossario}% Incrementa o contador do glossario
    \newglossaryentry{Def.\arabic{count_glossario}}{%
        name={#1:},%
        description={#2},%
    }%
}

% Alteracao no formato do nome do glossario que aparece no sumario
\ifthenelse{\boolean{ABNTEXupperchapter}}{
    \renewcommand{\glssettoctitle}[1]{%
        \renewcommand{\glossarytoctitle}{%
            \texorpdfstring{\MakeTextUppercase{\csname @glotype@#1@title\endcsname}}{\csname @glotype@#1@title\endcsname}
        }
    }
}{}


%================================================================================
% Pacotes de citacoes
%================================================================================

% Configuracoes do pacote backref
% Texto padrao antes do numero das paginas
\renewcommand{\backref}{}
% Define os textos da citacao
\addto\captionsbrazil{% portugues-brasil
    \renewcommand*{\backreftwosep}{ e~} % inserido entre as entradas de uma lista com duas itens.
    \renewcommand*{\backreflastsep}{ e~} % inserido entre as ultimas duas entradas de uma lista com varios itens.
    % Usado sem a opcao hyperpageref de backref
    \renewcommand{\backrefpagesname}{Citado na(s) p{\'a}gina(s):~}
    \renewcommand*{\backrefalt}[4]{
    	\ifcase #1 %
    		Nenhuma cita{\c c}{\~a}o no texto.%
    	\or
    		Citado na p{\'a}gina #2.%
    	\else
    		Citado nas p{\'a}ginas #2.%
    	\fi}%
}
\addto\captionsenglish{% ingles
    % Usado sem a opcao hyperpageref de backref
    \renewcommand*{\backreftwosep}{ and~} % inserido entre as entradas de uma lista com duas itens.
    \renewcommand*{\backreflastsep}{, and~} % inserido entre as ultimas duas entradas de uma lista com varios itens.
    \renewcommand{\backrefpagesname}{Cited on page(s):~}
    \renewcommand*{\backrefalt}[4]{
    	\ifcase #1 %
    		No citation.%
    	\or
    		Citation on page #2.%
    	\else
    		Citations on pages #2.%
    	\fi}%
}


%================================================================================
% Definicao/Alteracao de comandos uitlizados
%================================================================================

% Permite comandos com @ no nome
\makeatletter

% Comando para selecionar o idioma principal do texto
\providecommand{\imprimiridioma}{PT}
\newcommand{\idioma}[1]{
    \renewcommand{\imprimiridioma}{#1}
    \IfEq{\imprimiridioma}{EN}{}{
        \IfEq{\imprimiridioma}{PT}{}{
            \PackageError{ICMC}{Ilegal parameter of idioma}{
                Unknow language "#1"!
                Please, use "PT" to portuguese language or "EN" to english language. The option must be in uppercase.
            }
            \stop
        }
    }
}
% Checagem dos dialetos da lingua portuguesa
\newcommand*{\IfLangPortuguese}{%
  \iflanguage{brazil}\@firstoftwo\@secondoftwo%
}

% Comando para definir o titulo em portugues
\providecommand{\imprimirtituloPT}{}
\newcommand{\tituloPT}[1]{\renewcommand{\imprimirtituloPT}{#1}}%

% Comando para definir o titulo em ingles
\providecommand{\imprimirtituloEN}{}
\newcommand{\tituloEN}[1]{\renewcommand{\imprimirtituloEN}{#1}}%

\providecommand{\imprimirmaintitle}{}
\IfLangPortuguese{\renewcommand{\imprimirmaintitle}{\imprimirtituloPT}}{\renewcommand{\imprimirmaintitle}{\imprimirtituloEN}}

\addto\captionsenglish{% ingles
    \titulo{\imprimirtituloEN}
}
\addto\captionsbrazil{% portugues-brasil
    \titulo{\imprimirtituloPT}
}

% Comando para definir o genero do autor (M = Masculino / F = Feminino)
\providecommand{\imprimirgenero}{M}
\newcommand{\genero}[1]{
    \renewcommand{\imprimirgenero}{#1}
    \IfEq{\imprimirgenero}{M}{}{
        \IfEq{\imprimirgenero}{F}{}{
            \PackageError{ICMC}{Ilegal parameter of genero}{
                Unknow gender "#1"!
                Please, use "M" or "F". The option must be in uppercase.
            }
            \stop
        }
    }
}

% Comando para definicao do nome e sobrenome do autor
\renewcommand\autor[2][Nome para Referencia]{
    
    \StrCount{#2}{\space}[\nbmatch]%
    \StrCut[\nbmatch]{#2}{\space}\strfirstautor\strsecondautor

    \global\def\@authname{\strfirstautor}
    \global\def\@authsurn{\strsecondautor}
    \def\ABNTautordata{\@authname~\@authsurn}
    \renewcommand{\imprimirautor}{\@authname~\@authsurn}
    \def\ABNTautorreferencia{#1}
    \def\ABNTautordatabib{\@authsurn, \@authname}
    \global\def\@author{\@authname~\@authsurn}
}

% Retira os dois pontos (:) que vem por padrao da classe Abntex2
\addto\captionsbrazil{% portugues-brasil
    \renewcommand{\orientadorname}{Orientador}
    \renewcommand{\coorientadorname}{Coorientador}
}
\addto\captionsenglish{% ingles
    \renewcommand{\orientadorname}{Advisor}
    \renewcommand{\coorientadorname}{Co-advisor}
}

% Redefinicao do comando de orientador
\renewcommand{\orientador}[3][\orientadorname]{

    \StrCount{#3}{\space}[\nbmatch]%
    \StrCut[\nbmatch]{#3}{\space}\strfirstorientador\strsecondorientador
    
    \addto\captionsbrazil{% portugues-brasil
        \renewcommand{\imprimirorientadorRotulo}{#1}
    }
    \addto\captionsenglish{
        \renewcommand{\imprimirorientadorRotulo}{\orientadorname}
    }
    \newcommand{\titulacaoorientador}{#2}
    \def\ABNTorientadordatabib{\strsecondorientador, \strfirstorientador}
    \renewcommand{\imprimirorientador}{\strfirstorientador~\strsecondorientador}
}

% Redefinicao do comando de co-orientador
\renewcommand{\coorientador}[3][\coorientadorname]{

    \StrCount{#3}{\space}[\nbmatch]%
    \StrCut[\nbmatch]{#3}{\space}\strfirstcoorientador\strsecondcoorientador
    
    \addto\captionsbrazil{% portugues-brasil
        \renewcommand{\imprimircoorientadorRotulo}{#1}
    }
    \addto\captionsenglish{
        \renewcommand{\imprimircoorientadorRotulo}{\coorientadorname}
    }
    \newcommand{\titulacaocoorientador}{#2}
    \def\ABNTcoorientadordatabib{\strsecondcoorientador, \strfirstcoorientador}
    \renewcommand{\imprimircoorientador}{\strfirstcoorientador~\strsecondcoorientador}
}

% Comando para definicao da area de concentracao
\providecommand{\imprimirarea}{}
\newcommand{\area}[1]{\renewcommand{\imprimirarea}{#1}}

% Comando para definicao da especialidade do Titulo
\providecommand{\imprimirespecialidade}{}
\newcommand{\especialidade}[1]{\renewcommand{\imprimirespecialidade}{#1}}

% Comando para definicao do nome do Programa
\providecommand{\imprimirprograma}{}
\providecommand{\imprimirsiglaprograma}{}
\newcommand{\programa}[2]{
    \renewcommand{\imprimirsiglaprograma}{#1}
    \renewcommand{\imprimirprograma}{#2}
}

% Comando para definicao da Universidade
\providecommand{\imprimiruniversidade}{}
\newcommand{\universidade}[1]{\renewcommand{\imprimiruniversidade}{#1}}

% Camando para definicao do programa de Pos-Graduacao, Especialidade do Titulo e Instituicao
\newcommand{\curso}[1]{

\addto\captionsbrazil{
    \universidade{USP}
    \instituicao{Instituto de Ci{\^e}ncias Matem{\'a}ticas e de Computa{\c c}{\~a}o -- ICMC-USP}
}
\addto\captionsenglish{% ingles
    \universidade{USP}
    \instituicao{Instituto de Ci{\^e}ncias Matem{\'a}ticas e de Computa{\c c}{\~a}o -- ICMC-USP}
}

% CCMC ==========================================================================
    \ifthenelse{\equal{#1}{CCMC}}{
        \addto\captionsbrazil{
            \area{Ci{\^e}ncias de Computa{\c c}{\~a}o e Matem{\'a}tica Computacional}
            \programa{PPG-CCMC}{Programa de P{\'o}s-Gradua{\c c}{\~a}o em Ci{\^e}ncias de Computa{\c c}{\~a}o e Matem{\'a}tica Computacional}
            \especialidade{em Ci{\^e}ncias -- Ci{\^e}ncias de Computa{\c c}{\~a}o e Matem{\'a}tica Computacional}
        }
        \addto\captionsenglish{% ingles
            \area{Computer Science and Computational Mathematics}
            \especialidade{in Science}
            \programa{PPG-CCMC}{Computer and Mathematical Sciences Graduate Program}
        }
    }{
% MAT ===========================================================================
        \ifthenelse{\equal{#1}{MAT}}{
            \addto\captionsbrazil{
                \area{Matem{\'a}tica}
                \programa{PPG-Mat}{Programa de P{\'o}s-Gradua{\c c}{\~a}o em Matem{\'a}tica}
                \especialidade{em Ci{\^e}ncias -- Matem{\'a}tica}
            }
            \addto\captionsenglish{% ingles
                \area{Mathematics}
                \especialidade{in Science}
                \programa{PPG-Mat}{Mathematics Graduate Program}
            }
        }{
% PIPGES ========================================================================
            \ifthenelse{\equal{#1}{PIPGES}}{
                \addto\captionsbrazil{
                    \instituicao{Instituto de Ci{\^e}ncias Matem{\'a}ticas e de Computa{\c c}{\~a}o -- ICMC-USP e ao Departamento de Estat{\'i}stica -- DEs-UFSCar}
                    \area{Estat{\'i}stica}
                    \programa{PIPGEs}{Programa Interinstitucional de P{\'o}s-Gradua{\c c}{\~a}o em Estat{\'i}stica}
                    \especialidade{em Estat{\'i}stica -- Programa Interinstitucional de P{\'o}s-Gradua{\c c}{\~a}o em Estat{\'i}stica}
                }
                \addto\captionsenglish{% ingles
                    \instituicao{Institute of Mathematics and Computer Science -- ICMC-USP and to the Department of Statistics -- DEs-UFSCar}
                    \area{Statistics}
                    \especialidade{in Statistics}
                    \programa{PIPGEs}{Statistics Interagency Graduate Program}
                }
            }{
% PROFMAT =======================================================================
                \ifthenelse{\equal{#1}{PROFMAT}}{
                    \addto\captionsbrazil{
                        \area{Mestrado Profissional em Matem{\'a}tica em Rede Nacional}
                        \programa{PROFMAT}{Programa de Mestrado Profissional em Matem{\'a}tica em Rede Nacional}
                        \especialidade{em Ci{\^e}ncias -- Mestrado Profissional em Matem{\'a}tica em Rede Nacional}
                    }
                    \addto\captionsenglish{% ingles
                        \area{Professional Master Degree Program in Mathematics in National Network}
                        \especialidade{in Science} 
                        \programa{PROFMAT}{Professional Master's Program in Mathematics in National Network}
                    }
                }{
% MECAI =========================================================================
                    \ifthenelse{\equal{#1}{MECAI}}{
                        \addto\captionsbrazil{
                            \area{Matem{\'a}tica, Estat{\'i}stica e Computa{\c c}{\~a}o}
                            \programa{MECAI}{Programa de Mestrado Profissional em Matem{\'a}tica, Estat{\'i}stica e Computa{\c c}{\~a}o Aplicadas {\`a} Ind{\'u}stria}
                            \especialidade{-- Mestrado Profissional em Matem{\'a}tica, Estat{\'i}stica e Computa{\c c}{\~a}o Aplicadas {\`a} Ind{\'u}stria}
                        }
                        \addto\captionsenglish{% ingles
                            \area{Mathematics, Statistics and Computing}
                            \especialidade{in Science}
                            \programa{MECAI}{Professional Master's Program in Mathematics Statistics and Computing Applied to Industry}
                        }
                    }{
% Outros ========================================================================
                        \PackageError{ICMC}{Ilegal parameter of curso}{
                            Unknow curso "#1"!
                            Please, use "CCMC", "MAT", "PIPGES", "PROFMAT", or "MECAI". The option must be in upperrcase.
                        }
                        \stop
                    }
                }
            }
        }
    }

}

% Redefinicao do comando \date do Latex
\renewcommand{\date}[3]{%
  \gdef\@day{#1}%
  \gdef\@month{#2}%
  \gdef\@year{#3}%
}

% Define a data
\date{\number\day}{\number\month}{\number\year}

% Redefinicao do comando de data do ABNTex
\renewcommand{\data}[3]{%
    \date{#1}{#2}{#3}%
}

% Nome do Mes
\providecommand*{\Monthname}{}
\addto\captionsbrazil{
    \renewcommand\Monthname[1][EMPTY]{%
      \ifnum1=#1Janeiro\else
      \ifnum2=#1Fevereiro\else
      \ifnum3=#1Mar{\c c}o\else
      \ifnum4=#1Abril\else
      \ifnum5=#1Maio\else
      \ifnum6=#1Junho\else
      \ifnum7=#1Julho\else
      \ifnum8=#1Agosto\else
      \ifnum9=#1Setembro\else
      \ifnum10=#1Outubro\else
      \ifnum11=#1Novembro\else
      \ifnum12=#1Dezembro\else
      \fi\fi\fi\fi\fi\fi\fi\fi\fi\fi\fi\fi
    }
}
\addto\captionsenglish{% ingles
    \renewcommand\Monthname[1][EMPTY]{%
      \ifnum1=#1January\else
      \ifnum2=#1February\else
      \ifnum3=#1March\else
      \ifnum4=#1April\else
      \ifnum5=#1May\else
      \ifnum6=#1June\else
      \ifnum7=#1July\else
      \ifnum8=#1August\else
      \ifnum9=#1September\else
      \ifnum10=#1October\else
      \ifnum11=#1November\else
      \ifnum12=#1December\else
      \fi\fi\fi\fi\fi\fi\fi\fi\fi\fi\fi\fi
    }
}

% Opcao para exibir a lista de figuras
\newcommand{\incluilistadefiguras}{
  \gdef\@incluilistadefiguras{true}
}

% Opcao para exibir a lista de tabelas
\newcommand{\incluilistadetabelas}{
  \gdef\@incluilistadetabelas{true}
}

% Opcao para exibir a lista de siglas
\newcommand{\incluilistadesiglas}{
  \gdef\@incluilistadesiglas{true}
}

% Opcao para exibir a lista de simbolos
\newcommand{\incluilistadesimbolos}{
  \gdef\@incluilistadesimbolos{true}
}

% Opcao para exibir a lista de quadros
\newcommand{\incluilistadequadros}{
  \gdef\@incluilistadequadros{true}
}

% Opcao para exibir a lista de algoritmos
\newcommand{\incluilistadealgoritmos}{
  \gdef\@incluilistadealgoritmos{true}
}

% Opcao para exibir a lista de codigos
\newcommand{\incluilistadecodigos}{
  \gdef\@incluilistadecodigos{true}
}

% Comando para inclusao da ficha catalografica
\newboolean{opt-fichacatalografica}
\setboolean{opt-fichacatalografica}{false}
\newcommand{\incluifichacatalografica}[1]{
    % Incluir um arquivo externo como ficha catalografica
    \setboolean{opt-fichacatalografica}{true}%
    \gdef\@arquivofichacatalografica{#1}%
}


%================================================================================
% Definicao dos ambientes matematicos
%================================================================================

\providecommand*{\theoremaname}{Theorem}
\providecommand*{\proposicaoname}{Proposition}
\providecommand*{\lemaname}{Lemma}
\providecommand*{\corolarioname}{Corollary}
\providecommand*{\exemploname}{Example}
\providecommand*{\observacaoname}{Note}
\providecommand*{\definicaoname}{Definition}
\providecommand*{\demonstracaoname}{Demonstration}

\addto\captionsbrazil{% portugues-brasil
    \renewcommand{\theoremaname}{Teorema}
    \renewcommand{\proposicaoname}{Proposi{\c c}{\~a}o}
    \renewcommand{\lemaname}{Lema}
    \renewcommand{\corolarioname}{Corol{\'a}rio}
    \renewcommand{\exemploname}{Exemplo}
    \renewcommand{\observacaoname}{Observa{\c c}{\~a}o}
    \renewcommand{\definicaoname}{Defini{\c c}{\~a}o}
    \renewcommand{\demonstracaoname}{Demonstra{\c c}{\~a}o}
}

\addto\captionsenglish{% ingles
	\renewcommand{\theoremaname}{Theorem}
	\renewcommand{\proposicaoname}{Proposition}
	\renewcommand{\lemaname}{Lemma}
	\renewcommand{\corolarioname}{Corollary}
	\renewcommand{\exemploname}{Example}
	\renewcommand{\observacaoname}{Note}
	\renewcommand{\definicaoname}{Definition}
	\renewcommand{\demonstracaoname}{Demonstration}
}

\theoremstyle{definition}
\newtheorem{teorema}{\theoremaname}
\newtheorem{proposicao}{\proposicaoname}
\newtheorem{lema}{\lemaname}
\newtheorem{corolario}{\corolarioname}
\newtheorem{exemplo}{\exemploname}
\newtheorem{observacao}{\observacaoname}
\newtheorem{definicao}{\definicaoname}
\newenvironment{demonstracao}{\begin{proof}[\demonstracaoname]}{\end{proof}}


%================================================================================
% Criacao dos Ambientes Flutuantes para Quadros
%================================================================================

\newcommand{\listquadroname}{Lista de quadros}
\newcommand{\quadroname}{Quadro}
\newcommand{\quadrorefname}{Quadro}
\newcommand{\chartautorefname}{Quadro}

\addto\captionsenglish{% ingles
    \renewcommand{\listquadroname}{List of charts}
    \renewcommand{\quadroname}{Chart}
    \renewcommand{\quadrorefname}{Chart}
    \renewcommand{\chartautorefname}{Chart}
}

\newfloat{quadro}{htbp}{loq}[chapter]
\floatname{quadro}{\quadroname}
\floatstyle{plaintop}
\restylefloat{quadro}
\newlistof{listofquadros}{loq}{\listquadroname}
\newlistentry{quadro}{loq}{0}
\renewcommand{\thequadro}{\thechapter.\@arabic\c@quadro}
\setfloatadjustment{quadro}{\centering}

\renewcommand{\cftquadroname}{\quadroname\space}
\renewcommand*{\cftquadroaftersnum}{\hfill\textendash\hfill}


%================================================================================
% Criacao dos Ambientes Flutuantes para Algoritmos
%================================================================================

\newcommand{\listalgoritmoname}{Lista de algoritmos}
\newcommand{\algoritmoname}{Algoritmo}
\newcommand{\algoritmorefname}{Algoritmo}
\newcommand{\algorithmautorefname}{Algoritmo}

\addto\captionsenglish{% ingles
    \renewcommand{\listalgoritmoname}{List of algorithms}
    \renewcommand{\algoritmoname}{Algorithm}
    \renewcommand{\algoritmorefname}{Algorithm}
    \renewcommand{\algorithmautorefname}{Algorithm}
}

% Altera o rotulo a ser usando no elemento pre-textual "Lista de algoritmos"
\renewcommand{\listalgorithmname}{\listalgoritmoname}%
% Altera o nome padrao do rotulo
\floatname{algorithm}{\algoritmoname}

% Configura a ``Lista de algoritmos'' conforme as regras da ABNT (para abnTeX2)
\begingroup
  \let\newcounter\@gobble\let\setcounter\@gobbletwo
  \globaldefs\@ne \let\c@loldepth\@ne
  \newlistof{algorithmt}{loa}{\listalgorithmname}
  \newlistentry{algorithmt}{loa}{0}
\endgroup

\let\oldlistofalgorithms\listofalgorithms
\newcommand{\NEWnumberline}[1]{\hspace*{-12pt}\algoritmoname~#1~~\textendash~~}%
\renewcommand{\listofalgorithms}{%
  \let\OLDnumberline\numberline%
  \let\numberline\NEWnumberline%
  \oldlistofalgorithms%
  \let\numberline\OLDnumberline%
}%

% Cria um novo ambiente "algoritmo" que inclui o ambiente "algorithm"
\newenvironment{algoritmo}[1][htb]{
  \begin{algorithm}[#1]%
}{\end{algorithm}}


%================================================================================
% Criacao dos Ambientes Flutuantes para Cogidos
%================================================================================

\newcommand{\listcodigoname}{Lista de c{\'o}digos-fonte}
\newcommand{\codigoname}{C{\'o}digo-fonte}
\newcommand{\codigorefname}{C{\'o}digo-fonte}
\newcommand{\sourcecodeautorefname}{C{\'o}digo-fonte}

\addto\captionsenglish{% ingles
    \renewcommand{\listcodigoname}{List of source codes}
    \renewcommand{\codigoname}{Source code}
    \renewcommand{\codigorefname}{Source code}
    \renewcommand{\sourcecodeautorefname}{Source code}
}

% Altera o nome padrao do rotulo 
\renewcommand{\lstlistingname}{\codigoname}
% Altera o rotulo a ser usando no elemento pre-textual "Lista de codigos"
\renewcommand{\lstlistlistingname}{\listcodigoname}

% Configura a ``Lista de codigos'' conforme as regras da ABNT (para abnTeX2)
\begingroup
  \let\newcounter\@gobble\let\setcounter\@gobbletwo
  \globaldefs\@ne \let\c@loldepth\@ne
  \newlistof{listings}{lol}{\lstlistlistingname}
  \newlistentry{lstlisting}{lol}{0}
\endgroup

\renewcommand{\cftlstlistingaftersnum}{\hfill\textendash\hfill}

\let\oldlstlistoflistings\lstlistoflistings
\renewcommand{\lstlistoflistings}{%
   \begingroup%
   \let\oldnumberline\numberline%
   \renewcommand{\numberline}{\lstlistingname\space\oldnumberline}%
   \oldlstlistoflistings%
   \endgroup%
}
   
\renewcommand*\thelstnumber{\arabic{lstnumber}:}

% Cria um ambiente "codigo" estilizando o ambiente "lstlisting" 
\newcounter{countcodigo}
\setcounter{countcodigo}{1}
\lstnewenvironment{codigo}[1][]
  {\lstset{basicstyle=\ttfamily\ABNTEXfontereduzida,
            numbers=left, 
            numbersep=6pt,
            numberstyle=\ABNTEXfontereduzida,
            frame=tb,
            framerule=0.8pt,
            xleftmargin=20.25pt,
            framexleftmargin=21.25pt,
            framexbottommargin=5pt,
            framextopmargin=5pt,
            abovecaptionskip=10pt,
            #1
          }
}
{\setcounter{countcodigo}{\value{lstnumber}}}

\addto\captionsbrazil{% portugues-brasil
    \algrenewcommand\algorithmicend{\textbf{fim}}
    \algrenewcommand\algorithmicdo{\textbf{fa{\c c}a}}
    \algrenewcommand\algorithmicwhile{\textbf{enquanto}}
    \algrenewcommand\algorithmicfor{\textbf{para}}
    \algrenewcommand\algorithmicif{\textbf{se}}
    \algrenewcommand\algorithmicthen{\textbf{ent{\~a}o}}
    \algrenewcommand\algorithmicelse{\textbf{sen{\~a}o}}
    \algrenewcommand\algorithmicreturn{\textbf{retorna}}
    \algrenewcommand\algorithmicfunction{\textbf{fun{\c c}{\~a}o}}
    \algrenewcommand\algorithmicforall{\textbf{para todo}}
    \algrenewcommand\algorithmicloop{\textbf{la{\c c}o}}
    \algrenewcommand\algorithmicrepeat{\textbf{repita}}
    \algrenewcommand\algorithmicuntil{\textbf{at{\'e}}}
    \algrenewcommand\algorithmicprocedure{\textbf{procedimento}}
    \algrenewcommand\algorithmicrequire{\textbf{Requer:}}
    \algrenewcommand\algorithmicensure{\textbf{Assegure:}}
}
\addto\captionsenglish{% english
    \algrenewcommand\algorithmicend{\textbf{end}}
    \algrenewcommand\algorithmicdo{\textbf{do}}
    \algrenewcommand\algorithmicwhile{\textbf{while}}
    \algrenewcommand\algorithmicfor{\textbf{for}}
    \algrenewcommand\algorithmicif{\textbf{if}}
    \algrenewcommand\algorithmicthen{\textbf{then}}
    \algrenewcommand\algorithmicelse{\textbf{else}}
    \algrenewcommand\algorithmicreturn{\textbf{return}}
    \algrenewcommand\algorithmicfunction{\textbf{function}}
    \algrenewcommand\algorithmicforall{\textbf{for all}}
    \algrenewcommand\algorithmicloop{\textbf{loop}}
    \algrenewcommand\algorithmicrepeat{\textbf{repeat}}
    \algrenewcommand\algorithmicuntil{\textbf{until}}
    \algrenewcommand\algorithmicprocedure{\textbf{procedure}}
    \algrenewcommand\algorithmicrequire{\textbf{Require:}}
    \algrenewcommand\algorithmicensure{\textbf{Ensure:}}
}

% Rearranja os finais de cada estrutura
\algrenewtext{EndWhile}{\algorithmicend\ \algorithmicwhile}
\algrenewtext{EndFor}{\algorithmicend\ \algorithmicfor}
\algrenewtext{EndIf}{\algorithmicend\ \algorithmicif}
\algrenewtext{EndFunction}{\algorithmicend\ \algorithmicfunction}


%================================================================================
% Comando para configurar os captions no documento
%================================================================================
\renewcommand{\ABNTEXfontereduzida}{\small} % Fonte reduzida para 11pt, conforme recomendacao da USP
\DeclareCaptionFont{ABNTEXfontereduzida}{\ABNTEXfontereduzida}
\captionsetup{position=above, labelfont=ABNTEXfontereduzida, font=ABNTEXfontereduzida}

\DeclareCaptionFormat{listing}{\hrule height.8pt depth0pt #1#2#3}
\captionsetup[lstlisting]{format=listing,singlelinecheck=false, margin=0pt,labelsep=endash,labelfont=bf, font=normalsize}
\captionsetup[algorithm]{singlelinecheck=false, margin=0pt,labelsep=endash,labelfont=bf, font=normalsize}


%================================================================================
% Dedicatoria
%================================================================================

% Comando para definicao da dedicatoria
\def\textodedicatoria{\@ifstar\@textodedicatoria\@@textodedicatoria}
% Inclui texto de um arquivo como dedicatoria
\def\@textodedicatoria#1{\gdef\@dedicatoria{\input{#1}}} % \textodedicatoria*{}{} 
% Inclui o texto como dedicatoria
\def\@@textodedicatoria#1{\gdef\@dedicatoria{#1}}       % \textodedicatoria{}{}

% Criacao da dedicatoria
\newcommand{\inserededicatoria}{
    \@ifundefined{@dedicatoria}{}{
      \begin{dedicatoria}
        \vspace*{\fill}
        \centering
        \noindent
        \textit{\@dedicatoria}
        \vspace*{\fill}
      \end{dedicatoria}
    }
}


%================================================================================
% Agradecimentos
%================================================================================

% Comando para definicao dos agradecimentos
\def\textoagradecimentos{\@ifstar\@textoagradecimentos\@@textoagradecimentos}
% Inclui texto de um arquivo como agradecimentos
\def\@textoagradecimentos#1{\gdef\@agradecimentos{\input{#1}}} % \textoagradecimentos*{}{}
% Inclui o texto como agradecimentos
\def\@@textoagradecimentos#1{\gdef\@agradecimentos{#1}} % \textoagradecimentos{}{}

% Criacao dos agradecimentos
\newcommand{\insereagradecimentos}
{
  \@ifundefined{@agradecimentos}{}{
    \begin{agradecimentos}
      \@agradecimentos
    \end{agradecimentos}
  }
}


%================================================================================
% Epigrafe
%================================================================================

% Comando para definicao da epigafe
\def\textoepigrafe{\@ifstar\@textoepigrafe\@@textoepigrafe}
% Inclui texto de um arquivo como epigafe
\def\@textoepigrafe#1{\gdef\@epigrafe{\input{#1}}}      % \textoepigrafe*{}{} 
% Inclui o texto como epigafe
\def\@@textoepigrafe#1{\gdef\@epigrafe{#1}}             % \textoepigrafe{}{}
% Criacao da epigafe
\newcommand{\insereepigrafe}
{
  \@ifundefined{@epigrafe}{}{
	\begin{epigrafe}
      \vspace*{\fill}
	  \begin{flushright}
		\textit{\@epigrafe}
	  \end{flushright}
    \end{epigrafe}	 
    
  }
}


%================================================================================
% Lista de Simbolos
%================================================================================

% Comando para inserir simbolos na lista de simbolos
\newcommand{\simbolo}[2]{
  \addcontentsline{los}{simbolo}{\ensuremath{#1} --- #2}%
}

% Apresentacao dos simbolos na lista de simbolos
\newcommand\l@simbolo[2]{\par #1}

% Criacao da lista de simbolos
\newcommand{\inserelistadesimbolos}
{
  \@ifundefined{@incluilistadesimbolos}{}{
     \pretextualchapter{\listadesimbolosname}
     {\setlength{\parindent}{0cm}
       \@starttoc{los}
     }
     \cleardoublepage
  }
}


%================================================================================
% Ficha Catalografica
%================================================================================

\newcommand{\inserefichacatalografica}
{
    \@ifundefined{@arquivofichacatalografica}{
        \PackageError{ICMC}{Some file is missing}{
            A ficha catalografica nao foi inserida!
        }
    }{
        \begin{fichacatalografica}
            \includepdf{\@arquivofichacatalografica}
        \end{fichacatalografica}
    }
}


%================================================================================
% Resumo
%================================================================================

% Comando para definicao dos resumos e palavras-chave
\newcounter{numresumo}
\newcommand{\textoresumo}[3][\languagename]{
  \stepcounter{numresumo}%
  \csdef{res-language-\thenumresumo}{#1}
  \csdef{res-text-\thenumresumo}{#2}
  \csdef{res-keywords-\thenumresumo}{#3}
  \IfStrEq{#1}{\languagename}{\renewcommand{\palavraschave}{#3}}{}
}

\newcommand{\xselectlanguage}[1]{\begingroup\edef\x{\endgroup\noexpand\selectlanguage{#1}}\x}
\newenvironment{xotherlanguage}[1]{%
  \begingroup%
  \edef\temp{\endgroup\noexpand\otherlanguage{#1}}%
  \temp%
  \ignorespaces%
}{\endotherlanguage\ignorespacesafterend}

\providecommand{\imprimirlanguage}{brazil}

% Criacao do resumo e palavras chaves no documento
\newcommand{\insereresumo}
{

% Titulos do Resumo
\csdef{res-title-english}{Abstract}
\csdef{res-title-brazil}{Resumo}
\csdef{res-title-french}{R{\'e}sum{\'e}}
\csdef{res-title-spanish}{Resumen}
% Labels: Palavras-chave
\csdef{res-label-keywords-english}{Keywords}
\csdef{res-label-keywords-brazil}{Palavras-chave}
\csdef{res-label-keywords-french}{Mots-cl{\'e}s}
\csdef{res-label-keywords-spanish}{Palabras clave}

% Contador das palavras-chave
\newcounter{count}
\setcounter{count}{0}
  
  \whileboolexpr
    { test {\ifnumcomp{\value{count}}{<}{\thenumresumo}} }%
    {
        \stepcounter{count}
        
        \renewcommand{\imprimirlanguage}{\csuse{res-language-\thecount}}
        
        \if@openright\cleardoublepage\else\clearpage\fi
        \phantomsection
        \begin{resumo}[\csuse{res-title-\csuse{res-language-\thecount}}]
                \begin{SingleSpace}
                    \begin{otherlanguage}{brazil}
                    \IfEndWith{\ABNTautorreferencia}{.}{\MakeUppercase{\ABNTautorreferencia}}{\MakeUppercase{\ABNTautorreferencia}.}~%
                    \textbf{\IfEq{\imprimirlanguage}{english}{\imprimirtituloEN}{\imprimirtituloPT}}. %
                    \@year. \pageref{LastPage} p. \imprimirtipotrabalho~(\tipodocurso~\imprimirespecialidade) -- Instituto de Ci{\^e}ncias Matem{\'a}ticas e de Computa{\c c}{\~a}o, Universidade de S\~ao Paulo, \imprimirlocal, \@year.
                    \end{otherlanguage}
                \end{SingleSpace}
                
                \vskip 20pt
                \begin{xotherlanguage}{\imprimirlanguage}
                    \csuse{res-text-\thecount}
                    
                    \vspace{\onelineskip}
                    
                    \noindent
                    \textbf{\csuse{res-label-keywords-\csuse{res-language-\thecount}}:}
                    \@tempswafalse
                        \@for\next:=\csuse{res-keywords-\thecount}\do
                        {\if@tempswa,~\else\@tempswatrue\fi\next}.
                \end{xotherlanguage}
        \end{resumo}
    }
}


%================================================================================
% Definicao de comandos a serem inseridos diretamente no inicio do documento
%================================================================================

\newcommand{\inserelistadefiguras}
{
  \@ifundefined{@incluilistadefiguras}{}{
    \pdfbookmark[0]{\listfigurename}{lof}
    \listoffigures*
    \cleardoublepage
  }
}

\newcommand{\inserelistadetabelas}
{
  \@ifundefined{@incluilistadetabelas}{}{
    \pdfbookmark[0]{\listtablename}{lot}
    \listoftables*
    \cleardoublepage
  }
}

\newcommand{\inserelistadesiglas}
{
  \@ifundefined{@incluilistadesiglas}{}{
    \pdfbookmark[0]{\listadesiglasname}{listadesiglas}
    \printnomenclature
    \cleardoublepage
  }
}

\newcommand{\inserelistadequadros}
{
  \@ifundefined{@incluilistadequadros}{}{
    \pdfbookmark[0]{\listquadroname}{loq}
    \listofquadros*
    \cleardoublepage
  }
}

\newcommand{\inserelistadealgoritmos}
{
  \@ifundefined{@incluilistadealgoritmos}{}{
    \pdfbookmark[0]{\listalgoritmoname}{alg}
    \listofalgorithms
    \cleardoublepage
  }
}

\newcommand{\inserelistadecodigos}
{
  \@ifundefined{@incluilistadecodigos}{}{
    \pdfbookmark[0]{\lstlistlistingname}{lol}
    \begin{KeepFromToc}
    \lstlistoflistings
    \end{KeepFromToc}
    \cleardoublepage
  }
}


%================================================================================
% Configuracao da fonte utilizada na capa exigida pelo ICMC
%================================================================================

\newcommand{\@icmcFont}[2][]{\fontsize{#2}{#2}\ifthenelse{\isempty{#1}}{}{\fontspec[Mapping = tex-text, Path = packages/fonts/]{#1}}}

\ifthenelse{\boolean{luatex} \or \boolean{xetex}}{
  % Configuracao da fonte para a compilacao por XeLaTeX ou LuaLaTeX
  \RequirePackage{fontspec}
  \ifxetex
    \RequirePackage{xltxtra}
  \fi
    \newfontfamily{\arial}[
        Ligatures=TeX, % recommended
        Mapping         = tex-text,
        Path            = packages/fonts/,
        BoldFont        = *bd,
        ItalicFont      = *i,
        BoldItalicFont  = *bi]{arial}
    
    \newcommand\@icmcTitulo{\arial\bfseries}
    \newcommand\@icmcAutorCapa{\@icmcFont{14}\arial\bfseries}
    \newcommand\@icmcPrograma{\@icmcFont{11}\arial}
    \newcommand\@icmcTipoTrabalho{\@icmcFont{10}\arial}
    \newcommand\@icmcAutorFolhaRosto{\@icmcFont{13}\arial\bfseries}
    \newcommand\@icmcTituloFolhaRosto{\@icmcFont{17}\arial}
    \newcommand\@icmcOrientador{\@icmcFont{10}\arial}
    \newcommand\@icmcPreambulo{\@icmcFont{10}\arial}
    \newcommand\@icmcLocalData{\@icmcFont{11}\arial\bfseries}
    \newcommand\@icmcCarimbo{\@icmcFont{11}\arial}
    \newcommand\@icmcSVPG{\@icmcFont{8}\arial}
}{
    % Configuracao da fonte para a compilacao por pdfLaTeX
    \RequirePackage[T1]{fontenc}	    	% Selecao de codigos de fonte.
    \RequirePackage[utf8]{inputenc}		% Codificacao do documento (conversao automatica dos acentos)
      
    \newcommand\@icmcTitulo{\selectfont\usefont{T1}{phv}{b}{n}}
    \newcommand\@icmcAutorCapa{\fontsize{14pt}{1em}\selectfont\usefont{T1}{phv}{b}{n}}
    \newcommand\@icmcPrograma{\fontsize{11pt}{1em}\selectfont\usefont{T1}{phv}{m}{n}}
    \newcommand\@icmcTipoTrabalho{\fontsize{10pt}{1em}\selectfont\usefont{T1}{phv}{m}{n}}
    \newcommand\@icmcAutorFolhaRosto{\fontsize{13pt}{1em}\selectfont\usefont{T1}{phv}{b}{n}}
    \newcommand\@icmcTituloFolhaRosto{\fontsize{17pt}{1em}\selectfont\usefont{T1}{phv}{m}{n}}
    \newcommand\@icmcOrientador{\fontsize{10pt}{1em}\selectfont\usefont{T1}{phv}{m}{n}}
    \newcommand\@icmcPreambulo{\fontsize{10pt}{1em}\selectfont\usefont{T1}{phv}{m}{n}}
    \newcommand\@icmcLocalData{\fontsize{11pt}{1em}\selectfont\usefont{T1}{phv}{b}{n}}
    \newcommand\@icmcCarimbo{\fontsize{11pt}{1em}\selectfont\usefont{T1}{phv}{m}{n}}
    \newcommand\@icmcSVPG{\fontsize{8pt}{1em}\selectfont\usefont{T1}{phv}{m}{n}}
}


%================================================================================
% Configuracao do modelo de capa exigido pelo programa do ICMC
%================================================================================

% Configuracao para reduzir tamanho do Titulo da capa automaticamente
\NewEnviron{fittext}{\def\trysize{14pt}\retry}

\def\retry{%
  \expandafter\@firstofone
  {
    \edef\trysize{\the\dimexpr\trysize-0.1pt\relax}%
    \sbox0{%
      \begin{minipage}{144mm}%
        \linespread{1.0}
        \begingroup\edef\x{
          \endgroup\noexpand\fontsize{\trysize}{\trysize}\noexpand\@icmcTitulo%
        }%
        \x\BODY
      \end{minipage}%
    }%
  }%
  \dimen0=\dimexpr\ht0+\dp0\relax
  \ifdim\dimen0>.4\textwidth
    \expandafter\retry
  \else
    \expandafter\parindent0pt\begin{minipage}[c][47mm][c]{144mm}\usebox{0}\end{minipage}
  \fi
}
  
% alterando a capa
\renewcommand{\imprimircapa}{%
  \begin{capa}%

    \begin{textblock*}{144mm}(61mm,65mm)%
      \begin{fittext}
        \centering%
        \textcolor{blue-capa}{
          \nohyphens{\imprimirtitulo}
        }
      \end{fittext}
    \end{textblock*}%

    \begin{textblock*}{130mm}(81mm,123mm)%
      \noindent
      \begin{minipage}[t][65mm][t]{125mm}
        \begin{otherlanguage}{brazil}
          \begin{SingleSpace}
            \linespread{1.0}%
            \begin{flushleft}
              \nohyphens{%
                \color{blue-capa}%
                \maxsizebox{125mm}{5mm}{\@icmcAutorCapa\imprimirautor}%
                
                \vspace{3mm}%
                
                \ifthenelse{\boolean{opt-qualificacao}}{%
                    \@icmcPrograma Qualifica{\c c}{\~a}o de \tipodocurso~do \imprimirprograma~(\imprimirsiglaprograma)%
                }{%
                    \@icmcPrograma\imprimirtipotrabalho~de \tipodocurso~do \imprimirprograma~(\imprimirsiglaprograma)%
                }%
                
              }
            \end{flushleft}
          \end{SingleSpace}
        \end{otherlanguage}
      \end{minipage}
    \end{textblock*}%

    \AddToShipoutPictureBG*{\includegraphics[height=\paperheight]{packages/capa}}
    ~
    
  \end{capa}
}

% folha de rosto
\newboolean{carimbo-folha-rosto}
\setboolean{carimbo-folha-rosto}{true}
\renewcommand{\folhaderostocontent}{

  \vspace*{-6.2mm}
  \ifthenelse{\boolean{carimbo-folha-rosto}}{
    \makebox[14.9cm][r]{%
      \fbox{
        \parbox{7.2cm}{
          \vspace{0.3cm}
          \makebox[\linewidth][c]{\@icmcSVPG{SERVI{\c C}O DE P{\'O}S-GRADUA{\c C}{\~A}O DO ICMC-USP}}
          
          {
            \@icmcCarimbo
            \vspace{12pt}
            \hspace{2pt} Data de Dep{\'o}sito:
              
            \vspace{9pt}
            \hspace{2pt} Assinatura: \_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_
            \vspace{9pt}
          }
        }
      }
    }
  }{\vspace{2.95cm}}
  \begin{center}

    \vspace{0.5cm}

    {\@icmcAutorFolhaRosto\nohyphens{\imprimirautor}}

    \vfill

    \begin{Spacing}{1.5}
      {\@icmcTituloFolhaRosto\nohyphens{\imprimirtitulo}}
    \end{Spacing}

    \vfill

    \abntex@ifnotempty{\imprimirpreambulo}{%
      \hspace{.43\textwidth}
      \begin{minipage}{8.4cm}
        \begin{Spacing}{0.9}
          {\@icmcPreambulo\imprimirpreambulo}%
        
          \vspace{5pt}
          {\@icmcPreambulo\arealabel: \nohyphens{\imprimirarea}}%
        
          \vspace{5pt}
          {\@icmcOrientador\imprimirorientadorRotulo: \titulacaoorientador{} \nohyphens{\imprimirorientador}}%
          \abntex@ifnotempty{\imprimircoorientador}{%
              \\{\@icmcOrientador\imprimircoorientadorRotulo: \titulacaocoorientador{} \nohyphens{\imprimircoorientador}}
          }%
        \end{Spacing}
      \end{minipage}%
    }%

    \vspace{1cm}

    {
      \@icmcLocalData
      \imprimiruniversidade~-- S{\~a}o Carlos\\ 
      \IfLangPortuguese{\Monthname[\@month] de \@year\\}{\Monthname[\@month]~\@year\\}
    }
    \vspace*{1.2cm}
  \end{center}
  
} %folha de rosto


%================================================================================
% Configuracao dos Estilo dos Capitulo
%================================================================================

\makechapterstyle{icmc}{%
  \renewcommand{\chapterheadstart}{} 
  
  % Secao secundaria (Section) Caixa baixa, Negrito
  \renewcommand*{\cftsectionfont}{\bfseries}
  % Secao terciaria (Subsection) Caixa baixa, Negrito, italico
  \renewcommand*{\cftsubsectionfont}{\itshape\bfseries}
  % Secao quaternaria (Subsubsection) Caixa baixa, italico
  \renewcommand*{\cftsubsubsectionfont}{\itshape}
  % Secao quinquenaria (Subsubsubsection) Caixa baixa
  \renewcommand*{\cftparagraphfont}{\normalsize}

  % tamanhos de fontes de chapter e part	
  \setlength{\beforechapskip}{0pt}
  \renewcommand{\ABNTEXchapterfontsize}{\LARGE}
  \renewcommand{\chaptitlefont}{\ABNTEXchapterfont\bfseries\ABNTEXchapterfontsize}
  
  % tamanhos de fontes de section, subsection, subsubsection e subsubsubsection
  \setsecheadstyle{\ABNTEXsectionfont\ABNTEXsectionfontsize\bfseries\ABNTEXsectionupperifneeded}
  \setsubsecheadstyle{\ABNTEXsubsectionfont\ABNTEXsubsectionfontsize\bfseries\itshape\ABNTEXsubsectionupperifneeded}
  \setsubsubsecheadstyle{\ABNTEXsubsubsectionfont\ABNTEXsubsubsectionfontsize\itshape\ABNTEXsubsubsectionupperifneeded}
  \setsubsubsubsecheadstyle{\ABNTEXsubsubsubsectionfont\ABNTEXsubsubsubsectionfontsize\ABNTEXsubsubsubsectionupperifneeded}
 
  % impressao do numero do capitulo
  \renewcommand{\chapternamenum}{}
  
  % impressao do nome do capitulo
  \renewcommand{\printchaptername}{}
    
  % impressao do titulo do capitulo
  \def\printchaptertitle##1{%
    
    \setboolean{ABNTEXupperchapter}{true}
    
    \ifthenelse{\boolean{abntex@innonumchapter}}{
        \vskip 0ex \hrulefill\chaptitlefont\bfseries\ABNTEXchapterupperifneeded{##1}
        \vskip -0.6ex\hfill\rule{.8\textwidth}{0.5pt} 
        \vskip -2.8ex\hfill\rule{.8\textwidth}{2pt}
        \vskip 1.5ex
    
    }{% else
        {\hrulefill
        {\renewcommand{\arraystretch}{1.5} %  1 is the default, change whatever you need
        \begin{tabular}{|c|}
            \rowcolor{black}\color{white}\normalsize\ABNTEXchapterfont
              \ifthenelse{\boolean{abntex@apendiceousecao}}{\MakeTextUppercase{\appendixname}}{\MakeTextUppercase{\chaptername}}  \\ 
            \vspace{-1.5ex}\\ %coloquei para aumentar o espaco entre o titulo e o numero
            \resizebox{!}{1.1cm}{\ABNTEXchapterfont\thechapter}
            \\[2.5ex]
            \hline
        \end{tabular}}} \\
        \vskip 4.3ex \flushright\chaptitlefont\bfseries\ABNTEXchapterupperifneeded{##1} \\
        \vskip -0.6ex\hfill\rule{.8\textwidth}{0.5pt} \\
        \vskip -2.8ex\hfill\rule{.8\textwidth}{2pt} \\
        \vskip 1.5ex
	}    
  }

  % impressao do numero do capitulo     	
  \renewcommand{\printchapternum}{%
    \setboolean{abntex@innonumchapter}{false}%
  }
  \renewcommand{\afterchapternum}{}
  
  % impressao do capitulo nao numerado
  \renewcommand\printchapternonum{%
    \setboolean{abntex@innonumchapter}{true}%
  }
}
\chapterstyle{icmc}


%================================================================================
% Configuracoes diversas
%================================================================================

% informacoes do PDF
\hypersetup{
        unicode=true, % Codificacao dos caracteres especiais no Bookmark
		pdftitle={\@title}, 
		pdfauthor={\@author},
    	pdfsubject={\imprimirpreambulo},
	    pdfcreator={LaTeX with abnTeX2/ICMC-USP (v1.3.6)},
		pdfkeywords={\palavraschave}, 
		colorlinks={\colorlinks},   % colored links
    	linkcolor=blue,          	% color of internal links
    	citecolor=blue,        		% color of links to bibliography
    	filecolor=magenta,      	% color of file links
		urlcolor=blue,
		bookmarksdepth=4
}

% Define as cores basicas utilizadas no documento
\definecolor{blue}{RGB}{41,5,195}
\definecolor{white}{RGB}{255,255,255}
\definecolor{black}{RGB}{0,0,0}
\definecolor{blue-capa}{RGB}{16,62,93}

% Corrige warning gerado pelo uso do comando \uppercase
\ifthenelse{\boolean{ABNTEXsumario-abnt-6027-2012}}{%v
    \renewcommand{\bibsection}{%
        \chapter*{\bibname}
        \bibmark
        \ifnobibintoc\else
        \phantomsection
        \addcontentsline{toc}{chapter}{\texorpdfstring{\MakeTextUppercase{\bibname}}{\bibname}}
        \fi
        \prebibhook
    }
}{}

% Niveis de subsecoes
\setcounter{tocdepth}{4}
\setcounter{secnumdepth}{4}

% Ajusta o espacamento dos paragrafos do resumo
\setlength{\absparsep}{18pt}

% O tamanho do paragrafo e dado por:
\setlength{\parindent}{1.3cm}

% Controle do espacamento entre um paragrafo e outro:
\setlength{\parskip}{0.2cm}  % tente tambem \onelineskip

% Pasta padrao para as imagens
\graphicspath{{images/}}

% Nome do local do instituto
\local{S{\~a}o Carlos -- SP}

% Define o programa de Pos-Graduacao padrao para o template
\curso{CCMC}

% Indice remissivo
\makeindex


%================================================================================
% Configuracoes para definir idioma principal do documento
%================================================================================

\def\HyLang@DeclareLang#1#2#3{%
    \expandafter\HyLang@addto
        \csname extras#1\expandafter\endcsname
        \csname HyLang@#2\endcsname
    \begingroup
      \edef\x{\endgroup
        #3%
      }%
    \x
    \@namedef{HyLang@#1@done}{}%
  \begingroup
    \edef\x##1##2{%
      \noexpand\ifx##2\relax
        \errmessage{No definitions for language #2' found!}%
      \noexpand\fi
      \endgroup
      \noexpand\define@key{Hyp}{#1}[]{%
        \noexpand\@ifundefined{HyLang@#1@done}{%
          \noexpand\HyLang@addto{\noexpand##1}{\noexpand##2}%
          #3%
          \noexpand\@namedef{HyLang@#1@done}{}%
        }{}%
      }%
    }%
  \expandafter\x\csname extras#1\expandafter\endcsname
                \csname HyLang@#2\endcsname
}
% repeat the known language declarations
\HyLang@DeclareLang{english}{english}{}
\HyLang@DeclareLang{brazil}{portuges}{}
\HyLang@DeclareLang{spanish}{spanish}{}

\addto\extrasenglish{%
  \def\chapterautorefname{Chapter}%
}


%================================================================================
% Configuracoes ao iniciar documento
%================================================================================
\AtBeginDocument{

    % Altera o idioma principal caso o documento seja redigido em ingles
    \IfStrEq{\imprimiridioma}{EN}{
        \selectlanguage{english}
        \bibliographystyle{packages/abntexalfenglish}
    }{}
    
    % Centraliza o caption das tabelas do IBGE, conforme recomendacao da USP
    \renewcommand{\configurecaptions}{\captionstyle[singlelinecheck=on]{}}
    
    % suporte a alguns sequencias comuns do LaTeX, como -- para travessao
    \ifxetex
        \defaultfontfeatures{Mapping=tex-text}
    \else
        \ifluatex
            \defaultfontfeatures{Mapping=tex-text}
            \setmainfont[Ligatures=TeX, SmallCapsFont={* Caps}]{Latin Modern Roman} 
        \fi
    \fi
    
    \pretextual
    
    % Capa
    \ifthenelse{\boolean{opt-impressao}}{}{
        \imprimircapa
    }

    % Folha de rosto e Ficha catalografica (se houver)
    \ifthenelse{\boolean{opt-fichacatalografica}}{
        % (o * indica que havera a ficha bibliografica)
        \imprimirfolhaderosto*{}
		\inserefichacatalografica
		\newpage
    }{
        \imprimirfolhaderosto{}
    }
    
    \setboolean{carimbo-folha-rosto}{false}
    \IfLangPortuguese{
        \begin{otherlanguage}{english}
            \imprimirfolhaderosto{}
        \end{otherlanguage}
    }{
        \begin{otherlanguage}{brazil}
            \imprimirfolhaderosto{}
        \end{otherlanguage}
    }

    % DEDICATORIA / AGRADECIMENTO / EPIGRAFE
    \inserededicatoria
    \insereagradecimentos
    \insereepigrafe

    % RESUMOS
    \insereresumo

    % Insere as Listas que forem setadas no documento
    \inserelistadefiguras
    \inserelistadequadros    
    \inserelistadealgoritmos
    \inserelistadecodigos
    \inserelistadetabelas
    \inserelistadesiglas
    \inserelistadesimbolos

	\pdfbookmark[0]{\contentsname}{toc}
    \tableofcontents*
    \cleardoublepage
    
    % Configuracao dos caracteres especiais utilizados no pacote <listings>
    \lstset{%
        frame=top,
        frame=bottom,
        breakatwhitespace=false,         
        breaklines=true,                 
        keepspaces=true,                 
        numbers=left,                    
        numbersep=5pt,                  
        showspaces=false,                
        showstringspaces=false,
        showtabs=false,                  
        tabsize=2,
        inputencoding=utf8,
        extendedchars=true,
        literate=%
        {é}{{\'{e}}}1
        {è}{{\`{e}}}1
        {ê}{{\^{e}}}1
        {ë}{{\¨{e}}}1
        {É}{{\'{E}}}1
        {Ê}{{\^{E}}}1
        {û}{{\^{u}}}1
        {ù}{{\`{u}}}1
        {â}{{\^{a}}}1
        {à}{{\`{a}}}1
        {á}{{\'{a}}}1
        {ã}{{\~{a}}}1
        {Á}{{\'{A}}}1
        {Â}{{\^{A}}}1
        {Ã}{{\~{A}}}1
        {ç}{{\c{c}}}1
        {Ç}{{\c{C}}}1
        {õ}{{\~{o}}}1
        {ó}{{\'{o}}}1
        {ô}{{\^{o}}}1
        {Õ}{{\~{O}}}1
        {Ó}{{\'{O}}}1
        {Ô}{{\^{O}}}1
        {î}{{\^{i}}}1
        {Î}{{\^{I}}}1
        {í}{{\'{i}}}1
        {Í}{{\~{Í}}}1
        {Ú}{{\'U}}1
        {ú}{{\'u}}1
        {Ü}{{\"U}}1
        {ü}{{\"u}}1
    }
    
    % Numeracao continua do elementos do presentes no documento
    \counterwithout{quadro}{chapter}
    \counterwithout{lstlisting}{chapter}
    
    \mainmatter

    % Retira espaco extra obsoleto entre as frases.
    \frenchspacing
}


\AtEndDocument{
    \ifthenelse{\boolean{opt-impressao}}{}{
        \includepdf[pages={1}]{packages/contra-capa.pdf}
    }
}

% ---
% Finaliza comandos com @ no nome
\makeatother