%%
%% Customizações do abnTeX2 (http://abnTeX2.googlecode.com) para o 
%% Instituto de Ciências Matemáticas e de Computação, Universidade 
%% de São Paulo
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
\ProvidesClass{packages/icmc}[2016/10/10 v1.3.0 Classe ICMC baseado em abnTeX2 - Teses e Dissertações dos  
Programas de Pós-graduação do Instituto de Ciências Matemáticas e de Computação]
\RequirePackage{xifthen}

%================================================================================
% Declaração de opções
%================================================================================
% Opções:
% 	qualificacao:   Formata documento para qualificação
%   completa:       Formata documento para dissertação/tese
%	doutorado:      Formata documento para tese de doutorado
% 	mestrado:       Formata documento para dissertação de mestrado
% 	pre-defesa:     Formata documento para versão de defesa (utilizado 
%                   apenas para versão completa)
%   pro-defesa:     Formata documento para versão final (utilizado apenas
%                   para versão completa)
% -------------------------------------------------------------------------------

\DeclareOption*{%
    \PackageWarning{icmc}{Unknown option ‘\CurrentOption’}%
}

\newboolean{opt-qualificacao}
\DeclareOption{qualificacao}{
    \setboolean{opt-qualificacao}{true}
}
\DeclareOption{completo}{
    \setboolean{opt-qualificacao}{false}
}
\ExecuteOptions{completo}

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

%
% Repassa demais opções a abntex	
%
\DeclareOption*{%
  \PassOptionsToClass{\CurrentOption}{abntex2}%
}
\ProcessOptions\relax


%================================================================================
% Herança da classe `abntex2' e inclusão de pacotes e arquivos necessários
%================================================================================
\LoadClass[% -- opções da classe memoir --
	12pt,				% tamanho da fonte
	openright,			% capítulos começam em pág ímpar 
	                    % (insere página vazia caso preciso)
	twoside,			% para impressão em verso e anverso. Oposto a oneside
	a4paper,			% tamanho do papel. 
	chapter=TITLE		% títulos de capítulos convertidos em letras maiúsculas
	]{abntex2}
	

%================================================================================
% Pacotes fundamentais 
%================================================================================
\RequirePackage{babel}
\RequirePackage{morewrites}         % Resolve o erro “No room for a new \write”
\RequirePackage{cmap}				% Mapear caracteres especiais no PDF
\RequirePackage{lmodern}			% Usa a fonte Latin Modern.
\RequirePackage{lastpage}			% Usado pela Ficha catalográfica
\RequirePackage{indentfirst}		% Indenta o primeiro parágrafo de cada seção.
\RequirePackage{color, xcolor}      % Controle das cores
\RequirePackage{colortbl}           % Controle das cores das células da tabela
                                    % (utilizado no título)
\RequirePackage{graphicx}			% Inclusão de gráficos
\RequirePackage{caption}            % Pacote para definição dos captions
\RequirePackage{subcaption}         % Pacote para definição dos subcaptions (ambientes de subfigures)
\RequirePackage{microtype} 		    % para melhorias de justificação
\RequirePackage{pdfpages}           % inclusão de arquivos PDF
\RequirePackage{ifxetex}            % verifica se a compilação ocorre por xetex
\RequirePackage{ifluatex}           % verifica se a compilação ocorre por luatex
\RequirePackage{hyphenat}           % Pacote para retirar a hifenização do
                                    % Preâmbulo
\RequirePackage{xstring}            % Pacate para manipulação de Strings
\RequirePackage{etoolbox}           % Pacote utilizado para armazenamento de
                                    % resumos
\RequirePackage{amsthm, amsfonts, amsmath, amssymb} % Pacote para a definição dos ambientes matemáticos
\RequirePackage{mathptmx}           % Usando times para equações, opcional
\RequirePackage{listings}           % Pacote para formatação de diversos 
                                    % códigos fontes
\RequirePackage{algorithm, algpseudocode}  % Pacote para escrever algoritmos em pseudo-código
\RequirePackage{pgffor}             % Pacote utilizado para gerar as
                                    % palavras-chave da ficha catalográfica
\RequirePackage{nomencl}            % Pacote para criação da Lista de Siglas
\RequirePackage[noredefwarn,translate=babel,nonumberlist,style=list,toc]{glossaries}	 % Pacote para gerar o glossário
\RequirePackage[brazilian,hyperpageref]{backref} % Paginas com as citações na bibl
\RequirePackage{float}              % Pacote para criação de novos ambientes
%\usepackage[backend=biber,style=abnt,indent, bftitles,hyperref,backref]{biblatex}  % Citações padrão ABNT
\RequirePackage[alf,bibjustif,abnt-etal-text=it,abnt-repeated-author-omit=yes,abnt-emphasize=bf,abnt-etal-cite=3,abnt-etal-list=0]{abntex2cite}   % Citações padrão ABNT


%================================================================================
% Comando para configuração do tipo de trabalho
%================================================================================

\providecommand*{\tipoexemplar}{}
\providecommand*{\degree}{}
\providecommand*{\tipodocurso}{}
\providecommand*{\exam}{}
\providecommand*{\arealabel}{}

% Configuração do texto do preâmbulo
\addto\captionsenglish{% ingles
    \renewcommand{\exam}{ in partial fulfillment of the requirements for the degree}
}
\addto\captionsbrazil{% portugues-brasil
    \renewcommand{\exam}{ como parte dos requisitos para obten{\c c}{\~a}o do t{\'i}tulo de}
}

% Configuração da situação do trabalho entregue
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

% Configuração do tipo de trabalho para DOUTORADO ou MESTRADO
\ifthenelse{\boolean{opt-doutorado}}{
    \addto\captionsenglish{% ingles
        \renewcommand{\degree}{of the Doctorate}
        \renewcommand{\tipodocurso}{Doctorate Candidate}
        \tipotrabalho{Doctoral dissertation}
    }
    \addto\captionsbrazil{% portugues-brasil
        \ifthenelse{\equal{\imprimirgenero}{M}}{\renewcommand{\degree}{Doutor}}{\renewcommand{\degree}{Doutora}}
        \renewcommand{\tipodocurso}{Doutorado}
        \tipotrabalho{Tese}
    }
}{
    \addto\captionsenglish{% ingles
        \renewcommand{\degree}{of the Master}
        \renewcommand{\tipodocurso}{Master student}
        \tipotrabalho{Master dissertation}
    }
    \addto\captionsbrazil{% portugues-brasil
        \ifthenelse{\equal{\imprimirgenero}{M}}{\renewcommand{\degree}{Mestre}}{\renewcommand{\degree}{Mestra}}
        \renewcommand{\tipodocurso}{Mestrado}
        \tipotrabalho{Disserta{\c c}{\~a}o}
    }
}

% Configuração do tipo de trabalho como QUALIFICAÇAO de DOUTORADO ou MESTRADO
\ifthenelse{\boolean{opt-qualificacao}}{
    \addto\captionsenglish{% ingles
        \renewcommand{\exam}{ as part of the qualifying exam requisites of the}
        \tipotrabalho{Monograph}
        \renewcommand{\tipoexemplar}{}
    }
    \addto\captionsbrazil{% portugues-brasil
        \renewcommand{\exam}{ para o Exame de Qualifica{\c c}{\~a}o, como parte dos requisitos para obten{\c c}{\~a}o do t{\'i}tulo de}
        \tipotrabalho{Monografia}
        \renewcommand{\tipoexemplar}{}
    }
}{}

% Configuração do texto impresso no Preambulo
\addto\captionsenglish{% ingles
    \renewcommand{\imprimirpreambulo}{\nohyphens{\imprimirtipotrabalho~submitted to the \imprimirinstituicao,\exam~\degree~\imprimirespecialidade. \textit{\tipoexemplar}}}
    \renewcommand{\arealabel}{Concentration Area}
}
\addto\captionsbrazil{% portugues-brasil
    \renewcommand{\imprimirpreambulo}{\nohyphens{\imprimirtipotrabalho~apresentada ao \imprimirinstituicao,\exam~\degree~\imprimirespecialidade. \textit{\tipoexemplar}}}
    \renewcommand{\arealabel}{{\'A}rea de Concentra{\c c}{\~a}o}
}



%================================================================================
% Configuração da fonte utilizada na capa exigida pelo ICMC
%================================================================================

\newcommand{\@icmcFont}[2][]{\fontsize{#2}{#2}\ifthenelse{\isempty{#1}}{}{\fontspec[Mapping = tex-text, Path = packages/fonts/]{#1}}}

\ifxetex % Configuração da fonte para a compilação por XETEX
  \RequirePackage{fontspec}
  \RequirePackage{xltxtra}
    \newfontfamily{\arial}[
        Ligatures=TeX, % recommended
        Mapping         = tex-text,
        Path            = packages/fonts/,
        BoldFont        = *bd,
        ItalicFont      = *i,
        BoldItalicFont  = *bi]{arial}
    
    \newcommand\@icmcTitulo{\@icmcFont{18}\arial}
    \newcommand\@icmcAutorCapa{\@icmcFont{13}\arial\bfseries\itshape}
    \newcommand\@icmcAutorFolhaRosto{\@icmcFont{13}\arial\bfseries}
    \newcommand\@icmcTituloFolhaRosto{\@icmcFont{17}\arial}
    \newcommand\@icmcOrientador{\@icmcFont{10}\arial}
    \newcommand\@icmcPreambulo{\@icmcFont{10}\arial}
    \newcommand\@icmcLocalData{\@icmcFont{11}\arial\bfseries}
    \newcommand\@icmcCarimbo{\@icmcFont{11}\arial}
    \newcommand\@icmcSVPG{\@icmcFont{8}\arial}
\else
    \ifluatex % Configuração da fonte para a compilação por LUATEX
      \RequirePackage{fontspec}
        \newfontfamily{\arial}[
        Ligatures=TeX, % recommended
        Mapping         = tex-text,
        Path            = packages/fonts/,
        BoldFont        = *bd,
        ItalicFont      = *i,
        BoldItalicFont  = *bi]{arial}
      
        \newcommand\@icmcTitulo{\@icmcFont{18}\arial}
        \newcommand\@icmcAutorCapa{\@icmcFont{13}\arial\bfseries\itshape}
        \newcommand\@icmcAutorFolhaRosto{\@icmcFont{13}\arial\bfseries}
        \newcommand\@icmcTituloFolhaRosto{\@icmcFont{17}\arial}
        \newcommand\@icmcOrientador{\@icmcFont{10}\arial}
        \newcommand\@icmcPreambulo{\@icmcFont{10}\arial}
        \newcommand\@icmcLocalData{\@icmcFont{11}\arial\bfseries}
        \newcommand\@icmcCarimbo{\@icmcFont{11}\arial}
        \newcommand\@icmcSVPG{\@icmcFont{8}\arial}
    
    \else % Configuração da fonte para a compilação por PDFLATEX
      \RequirePackage[T1]{fontenc}	    	% Selecao de codigos de fonte.
      \RequirePackage[utf8]{inputenc}		% Codificacao do documento (conversão automática dos acentos)
      \newcommand\@icmcTitulo{\fontsize{18pt}{1em}\selectfont\usefont{T1}{phv}{m}{n}}
      \newcommand\@icmcAutorCapa{\fontsize{13pt}{1em}\selectfont\usefont{T1}{phv}{b}{it}}
      \newcommand\@icmcAutorFolhaRosto{\fontsize{13pt}{1em}\selectfont\usefont{T1}{phv}{b}{n}}
      \newcommand\@icmcTituloFolhaRosto{\fontsize{17pt}{1em}\selectfont\usefont{T1}{phv}{m}{n}}
      \newcommand\@icmcOrientador{\fontsize{10pt}{1em}\selectfont\usefont{T1}{phv}{m}{n}}
      \newcommand\@icmcPreambulo{\fontsize{10pt}{1em}\selectfont\usefont{T1}{phv}{m}{n}}
      \newcommand\@icmcLocalData{\fontsize{11pt}{1em}\selectfont\usefont{T1}{phv}{b}{n}}
      \newcommand\@icmcCarimbo{\fontsize{11pt}{1em}\selectfont\usefont{T1}{phv}{m}{n}}
      \newcommand\@icmcSVPG{\fontsize{8pt}{1em}\selectfont\usefont{T1}{phv}{m}{n}}
    \fi
\fi


%================================================================================
% Comando auxiliares
%================================================================================

% Comando para marcar texto para revisão
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

% Comandos utilizados para referenciar corpos flutuantes no texto
\newcommand{\qref}[1]{\quadrorefname~\ref{#1}}      % Quadro X
\newcommand{\aref}[1]{\algoritmorefname~\ref{#1}}   % Algoritmo X
\newcommand{\cref}[1]{\codigorefname~\ref{#1}}      % Código X


\newcommand{\ifequals}[3]{\ifthenelse{\equal{#1}{#2}}{#3}{}}
\newcommand{\case}[2]{#1 #2} % Dummy, so \renewcommand has something to overwrite...
\newenvironment{switch}[1]{\renewcommand{\case}{\ifequals{#1}}}{}

% Palavras-chave do resumo
\newcommand{\palavraschave}{}

%================================================================================
% Configurações diversas
%================================================================================

% ---
% Configurações de aparência do PDF final
% ---
% alterando o aspecto da cor azul
\definecolor{blue}{RGB}{41,5,195}

% informações do PDF
\hypersetup{
        unicode=true, % Codificação dos caracteres especiais no Bookmark
		pdftitle={\@title}, 
		pdfauthor={\@author},
    	pdfsubject={\imprimirpreambulo},
	    pdfcreator={LaTeX with abnTeX2/ICMC-USP},
		pdfkeywords={\palavraschave}, 
		colorlinks=true,       		% false: boxed links; true: colored links
    	linkcolor=blue,          	% color of internal links
    	citecolor=blue,        		% color of links to bibliography
    	filecolor=magenta,      	% color of file links
		urlcolor=blue,
		bookmarksdepth=4
}

% alterando o aspecto da cor azul
\definecolor{blue}{RGB}{41,5,195}
\definecolor{white}{RGB}{255,255,255}
\definecolor{black}{RGB}{0,0,0}


\providecommand*{\chartautorefname}{Chart}
\providecommand*{\algorithmautorefname}{Algorithm}
\providecommand*{\sourcecodeautorefname}{Source code}
\addto\captionsbrazil{% portugues-brasil
    %% ajusta nomes padroes do babel
    \renewcommand{\sectionrefname}{se{\c c}\~ao~}   % \Sref{ }
    \renewcommand{\chapterrefname}{Cap{\'i}tulo~}   % \Cref{ }
    \renewcommand{\appendixrefname}{Ap{\^e}ndice~}  % \Aref{ }
    \renewcommand{\bookrefname}{Livro~}             % \Bref{ }
    \renewcommand{\partrefname}{Parte~}             % \Pref{ }
    \renewcommand{\figurerefname}{Figura}           % \fref{ }
    \renewcommand{\tablerefname}{Tabela}            % \tref{ }
    \renewcommand{\pagerefname}{p{\'a}gina}         % \pref{ }
    %% ajusta nomes usados com a macro \autoref
    \renewcommand{\chartautorefname}{Quadro}
    \renewcommand{\algorithmautorefname}{Algoritmo}
    \renewcommand{\sourcecodeautorefname}{Código-fonte}
}

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

% Níveis de subseções
\setcounter{tocdepth}{4}
\setcounter{secnumdepth}{4}

% Ajusta o espaçamento dos parágrafos do resumo
\setlength{\absparsep}{18pt}

% O tamanho do parágrafo é dado por:
\setlength{\parindent}{1.3cm}

% Controle do espaçamento entre um parágrafo e outro:
\setlength{\parskip}{0.2cm}  % tente também \onelineskip

% Pasta padrão para as imagens
\graphicspath{{images/}}

% Nome do local do instituto
\local{São Carlos -- SP}


%================================================================================
% Pacote para criação da lista de siglas e abreviaturas
%================================================================================

% Configuração do pacote nomencl
% Tamanho da Label da sigla
\setlength{\nomlabelwidth}{0.15\hsize} 
% Separa as abreviaturas de suas definições com pontos (....)
\renewcommand{\nomlabel}[1]{#1 \hfill}
\setlength{\nomitemsep}{-.05in} 
% Comando necessário para a criação da lista de abreviaturas
\makenomenclature
% Traduz o título da lista de abreviaturas
\renewcommand{\nomname}{\listadesiglasname}

% Comando para criação de abreviaturas e siglas
\def\sigla{\@ifstar\@sigla\@@sigla}
% Apenas faz o registro na tabela de siglas
\def\@sigla#1#2{\nomenclature{#1}{#2}}          % \sigla*{}{} 
% Faz o registro na tabela de siglas e insere os dados no corpo do documento
\def\@@sigla#1#2{#2 (#1)\nomenclature{#1}{#2}}  % \sigla{}{}

%================================================================================
% Pacote para criação do GLOSSÁRIO
%================================================================================
% Gera o indíce do Glossário
\makeglossaries
% Traduz o nome do glossário
\addto\captionsbrazil{% portugues-brasil
    \renewcommand{\glossaryname}{Gloss\'ario}
}

% Contador de definições do Glossário
\newcounter{count_glossario}
% Comando para simplificar a definição de palavras no glossário
\newcommand{\newword}[2]{%
    \stepcounter{count_glossario}% Incrementa o contador do glossário
    \newglossaryentry{Def.\arabic{count_glossario}}{%
        name={#1:},%
        description={#2},%
    }%
}

% Alteração no formato do nome do glossário que aparece no sumário
\ifthenelse{\boolean{ABNTEXupperchapter}}{
    \renewcommand{\glssettoctitle}[1]{%
        \renewcommand{\glossarytoctitle}{%
            \texorpdfstring{\MakeTextUppercase{\csname @glotype@#1@title\endcsname}}{\csname @glotype@#1@title\endcsname}
        }
    }
}{}



%================================================================================
% Pacotes de citações
%================================================================================

% Configurações do pacote backref
% Texto padrão antes do número das páginas
\renewcommand{\backref}{}
% Define os textos da citação
\addto\captionsbrazil{% portugues-brasil
    % Usado sem a opção hyperpageref de backref
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
    % Usado sem a opção hyperpageref de backref
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
% ---

%================================================================================
% Definição/Alteração de comandos uitlizados
%================================================================================

% Permite comandos com @ no nome
\makeatletter

% Checagem dos dialetos da língua portuguesa (portuges, portuguese, brazilian, brazil)
\newcommand*{\IfLangPortuguese}{%
  % A comando pode ser otimizado, colocando nomes por ordem de frequência de utilização.
  \iflanguage{brazil}\@firstoftwo{%
  \iflanguage{brazilian}\@firstoftwo{%
  \iflanguage{portuguese}\@firstoftwo{%
  \iflanguage{portuges}\@firstoftwo\@secondoftwo}}}%
}

% Comando para definir o título em português
\providecommand{\imprimirtituloPT}{}
\newcommand{\tituloPT}[1]{\renewcommand{\imprimirtituloPT}{#1}}%

% Comando para definir o título em inglês
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


% Comando para definir o gênero do autor (M = Masculino / F = Feminino)
\providecommand{\imprimirgenero}{M}
\newcommand{\genero}[1]{\renewcommand{\imprimirgenero}{#1}}

% Comando para definição do nome e sobrenome do author
\renewcommand\autor[2][Nome para Referência]{
    
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

% Retira os dois pontos (:) que vem por padrão da classe Abntex2
\addto\captionsbrazil{% portugues-brasil
    \renewcommand{\orientadorname}{Orientador}
    \renewcommand{\coorientadorname}{Coorientador}
}
\addto\captionsenglish{% ingles
    %% adjusts names from abnTeX2
    \renewcommand{\orientadorname}{Advisor}
    \renewcommand{\coorientadorname}{Co-advisor}
}

% Redefinição do comando de orientador
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

% Redefinição do comando de co-orientador
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

% Comando para definição da área de concentração
\providecommand{\imprimirarea}{}
\newcommand{\area}[1]{\renewcommand{\imprimirarea}{#1}}

% Comando para definição da especialidade do Título
\providecommand{\imprimirespecialidade}{}
\newcommand{\especialidade}[1]{\renewcommand{\imprimirespecialidade}{#1}}

% Comando para definição do nome do Programa
\providecommand{\imprimirprograma}{}
\newcommand{\programa}[1]{\renewcommand{\imprimirprograma}{#1}}

% Comando para definição da Universidade
\providecommand{\imprimiruniversidade}{}
\newcommand{\universidade}[1]{\renewcommand{\imprimiruniversidade}{#1}}

% Camando para definição do programa de Pós-Graduação, Especialidade do Título e Instituição
\newcommand{\curso}[1]{

\universidade{USP}
\instituicao{Instituto de Ciências Matemáticas e de Computação -- ICMC-USP}

% CCMC ==========================================================================
    \ifthenelse{\equal{#1}{CCMC}}{
        \addto\captionsbrazil{
            \area{Ciências de Computação e Matemática Computacional}
            \programa{Programa de Pós-Graduação em Ciências de Computação e Matemática Computacional}
            \especialidade{em Ciências -- Ciências de Computação e Matemática Computacional}
        }
        \addto\captionsenglish{% ingles
            \area{Computer Science and Computational Mathematics}
            %\programa{Programa de Pós-Graduação em Ciências de Computação e Matemática Computacional}
            \especialidade{Program in Computer Science and Computational Mathematics}
        }
    }{
% MAT ===========================================================================
        \ifthenelse{\equal{#1}{MAT}}{
            \addto\captionsbrazil{
                \area{Matemática}
                \programa{Programa de Pós-Graduação em Matemática}
                \especialidade{em Ciências -- Matemática}
            }
            \addto\captionsenglish{% ingles
                \area{Mathematics}
                %\programa{Programa de Pós-Graduação em Matemática}
                \especialidade{Program in Mathematics}
            }
        }{
% PIPGES ========================================================================     
            \ifthenelse{\equal{#1}{PIPGES}}{
                \addto\captionsbrazil{
                    \universidade{USP/UFSCar}
                    \instituicao{Instituto de Ciências Matemáticas e de Computação -- ICMC-USP e ao Departamento de Estatística -- DEs-UFSCar}
                    \area{Estatística}
                    \programa{Programa Interinstitucional de Pós-Graduação em Estatística}
                    \especialidade{em Estatística -- Interinstitucional de Pós-Graduação em Estatística}
                }
                \addto\captionsenglish{% ingles
                    \universidade{USP/UFSCar}
                    \instituicao{Instituto de Ciências Matemáticas e de Computação -- ICMC-USP and to the Departamento de Estatística -- DEs-UFSCar}
                    \area{Statistics}
                    %\programa{Programa Interinstitucional de Pós-Graduação em Estatística}
                    \especialidade{joint Graduate Program in Statistics DEs-UFSCar/ICMC-USP}
                }
            }{
% PROFMAT =======================================================================
                \ifthenelse{\equal{#1}{PROFMAT}}{
                    \addto\captionsbrazil{
                        \area{Matemática}
                        \programa{Programa de Pós-graduação em Mestrado Profissional em Matemática em Rede Nacional}
                        \especialidade{em Ciências -- Programa de Mestrado Profissional em Matemática}
                    }
                    \addto\captionsenglish{% ingles
                        \area{Mathematics}
                        %\programa{Programa de Pós-graduação em Mestrado Profissional em Matemática em Rede Nacional}
                        \especialidade{of Mathematics Professional Master’s Program}
                        \renewcommand{\imprimirpreambulo}{\nohyphens{\imprimirtipotrabalho~submitted to the \imprimirinstituicao,\exam~\imprimirespecialidade. \textit{\tipoexemplar}}}
                    }
                }{
% MECAI =========================================================================
                    \ifthenelse{\equal{#1}{MECAI}}{
                        \addto\captionsbrazil{
                            \area{Matemática, Estatística e Computação Aplicadas à Indústria}
                            \programa{Programa de Pós-graduação em Mestrado Profissional em Matemática, Estatística e Computação Aplicadas à Indústria}
                            \especialidade{-- Programa de Mestrado Profissional em Matemática, Estatística e Computação Aplicadas à Indústria}
                        }
                        \addto\captionsenglish{% ingles
                            \area{Mathematics, Statistics and Computing Applied to Industry}
                            %\programa{Programa de Pós-graduação em Mestrado Profissional em Matemática, Estatística e Computação Aplicadas à Indústria}
                            \especialidade{-- Program in Mathematics, Statistics and Computing Applied to Industry}
                        }
                    }{
% Outros ========================================================================
                        \programa{XXX}
                        \especialidade{XXX}
                    }
                }
            }
        }
    }

}

% Redefinição do comando \date do Latex
\renewcommand{\date}[3]{%
  \gdef\@day{#1}%
  \gdef\@month{#2}%
  \gdef\@year{#3}%
}

% Define a data
\date{\number\day}{\number\month}{\number\year}

% Redefinição do comando de data do ABNTex
\renewcommand{\data}[3]{%
    \date{#1}{#2}{#3}%
}

% Nome do Mês
% Nome do Mês
\providecommand*{\Monthname}{}
\addto\captionsbrazil{
    \renewcommand\Monthname[1][EMPTY]{%
        \ifnum1=#1Janeiro\else
        \ifnum2=#1Fevereiro\else
        \ifnum3=#1Março\else
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


% Comando para definição dos resumos e palavras-chave
\newcounter{numresumo}
\newcommand{\textoresumo}[3][\languagename]{
  \stepcounter{numresumo}%
  \csdef{res-language-\thenumresumo}{#1}
  \csdef{res-text-\thenumresumo}{#2}
  \csdef{res-keywords-\thenumresumo}{#3}
  \IfStrEq{#1}{\languagename}{\renewcommand{\palavraschave}{#3}}{}
}

% Opção para exibir a lista de figuras
\newcommand{\incluilistadefiguras}{
  \gdef\@incluilistadefiguras{true}
}

% Opção para exibir a lista de tabelas
\newcommand{\incluilistadetabelas}{
  \gdef\@incluilistadetabelas{true}
}

% Opção para exibir a lista de siglas
\newcommand{\incluilistadesiglas}{
  \gdef\@incluilistadesiglas{true}
}

% Opção para exibir a lista de símbolos
\newcommand{\incluilistadesimbolos}{
  \gdef\@incluilistadesimbolos{true}
}

% Opção para exibir a lista de quadros
\newcommand{\incluilistadequadros}{
  \gdef\@incluilistadequadros{true}
}

% Opção para exibir a lista de algoritmos
\newcommand{\incluilistadealgoritmos}{
  \gdef\@incluilistadealgoritmos{true}
}

% Opção para exibir a lista de códigos
\newcommand{\incluilistadecodigos}{
  \gdef\@incluilistadecodigos{true}
}

% Comando para inclusão da ficha catalográfica
\newboolean{opt-fichacatalografica}
\setboolean{opt-fichacatalografica}{false}
\def\incluifichacatalografica{\@ifstar\@incluifichacatalografica\@@incluifichacatalografica}
% Incluir um arquivo externo como ficha catalográfica
\def\@incluifichacatalografica#1{\setboolean{opt-fichacatalografica}{true}\gdef\@arquivofichacatalografica{#1}}          % \incluifichacatalografica*{}
% Gera a ficha catalográfica automaticamente de acordo com o número da Tabela de Cutter http://www.davignon.qc.ca/cutter1.html
\def\@@incluifichacatalografica#1{\setboolean{opt-fichacatalografica}{true}\gdef\@codigocutter{#1}}  % \incluifichacatalografica{}


%================================================================================
% Definição dos ambientes matemáticos
%================================================================================

\providecommand*{\theoremaname}{Theorem}
\providecommand*{\proposicaoname}{Proposition}
\providecommand*{\lemaname}{Lemma}
\providecommand*{\corolarioname}{Corollary}
\providecommand*{\exemploname}{Example}
\providecommand*{\observacaoname}{Note}
\providecommand*{\definicaoname}{Definition}
\providecommand*{\demonstracaoname}{Demonstration}

\providecommand*{\sourcecodeautorefname}{Source code}
\addto\captionsbrazil{% portugues-brasil
    %% ajusta nomes padroes do babel
    \renewcommand{\theoremaname}{Teorema}
    \renewcommand{\proposicaoname}{Proposi{\c c}{\~a}o}
    \renewcommand{\lemaname}{Lema}
    \renewcommand{\corolarioname}{Corol{\'a}rio}
    \renewcommand{\exemploname}{Exemplo}
    \renewcommand{\observacaoname}{Observa{\c c}{\~a}o}
    \renewcommand{\definicaoname}{Defini{\c c}{\~a}o}
    \renewcommand{\demonstracaoname}{Demonstra{\c c}{\~a}o}
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
% Criação dos Ambientes Flutuantes para Quadros, Algoritmos e Cógidos
%================================================================================

\newcommand{\listquadroname}{Lista de quadros}
\newcommand{\quadroname}{Quadro}
\newcommand{\quadrorefname}{Quadro}

\newcommand{\listalgoritmoname}{Lista de algoritmos}
\newcommand{\algoritmoname}{Algoritmo}
\newcommand{\algoritmorefname}{Algoritmo}

\newcommand{\listcodigoname}{Lista de c{\'o}digos-fonte}
\newcommand{\codigoname}{C{\'o}digo-fonte}
\newcommand{\codigorefname}{C{\'o}digo-fonte}

\addto\captionsenglish{% ingles
    %% adjusts names from abnTeX2
    \renewcommand{\listquadroname}{List of charts}
    \renewcommand{\quadroname}{Chart}
    \renewcommand{\quadrorefname}{Chart}
    \renewcommand{\listalgoritmoname}{List of algorithms}
    \renewcommand{\algoritmoname}{Algorithm}
    \renewcommand{\algoritmorefname}{Algorithm}
    \renewcommand{\listcodigoname}{List of source codes}
    \renewcommand{\codigoname}{Source code}
    \renewcommand{\codigorefname}{Source code}
}


% ---
% Formatação de ambiente Quadro
% ---
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



% ---
% Formatação de ambiente Algoritmo
% ---

% Altera o rótulo a ser usando no elemento pré-textual "Lista de algoritmos"
\renewcommand{\listalgorithmname}{\listalgoritmoname}%
% Altera o nome padrão do rótulo
%\renewcommand{\algorithmname}{\algoritmoname}%
\floatname{algorithm}{\algoritmoname}

% Configura a ``Lista de algoritmos'' conforme as regras da ABNT (para abnTeX2)
\begingroup
\let\newcounter\@gobble\let\setcounter\@gobbletwo
  \globaldefs\@ne \let\c@loldepth\@ne
  \newlistof{algorithmt}{loa}{\listalgorithmname}
  \newlistentry{algorithmt}{loa}{0}
\endgroup

   \let\oldlistofalgorithms\listofalgorithms
\newcommand{\NEWnumberline}[1]{\hspace*{-12pt}Algoritmo #1~~\textendash~~}%
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


% ---
% Formatação de código-fonte
% ---

% Altera o nome padrão do rótulo 
\renewcommand{\lstlistingname}{\codigoname}
% Altera o rótulo a ser usando no elemento pré-textual "Lista de códigos"
\renewcommand{\lstlistlistingname}{\listcodigoname}

% Configura a ``Lista de códigos'' conforme as regras da ABNT (para abnTeX2)
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
   \endgroup}
   
\def\lst@numbersymbol{}
\lst@Key{numbersymbol}{}{\def\lst@numbersymbol{#1}}
\lst@Key{numbers}{none}{%
    \let\lst@PlaceNumber\@empty
    \lstKV@SwitchCases{#1}%
    {none&\\%
     left&\def\lst@PlaceNumber{\llap{\normalfont
                \lst@numberstyle{\thelstnumber\lst@numbersymbol}\kern\lst@numbersep}}\\%
     right&\def\lst@PlaceNumber{\rlap{\normalfont
                \kern\linewidth \kern\lst@numbersep
                \lst@numberstyle{\lst@numbersymbol\thelstnumber}}}%
    }{\PackageError{Listings}{Numbers #1 unknown}\@ehc}
}

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
            numbersymbol=$:$,
            #1
          }
}
{\setcounter{countcodigo}{\value{lstnumber}}}

\addto\captionsbrazil{% portugues-brasil
% Declaracoes em Português
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
% Rearranja os finais de cada estrutura
\algrenewtext{EndWhile}{\algorithmicend\ \algorithmicwhile}
\algrenewtext{EndFor}{\algorithmicend\ \algorithmicfor}
\algrenewtext{EndIf}{\algorithmicend\ \algorithmicif}
\algrenewtext{EndFunction}{\algorithmicend\ \algorithmicfunction}
% O comando For, a seguir, retorna 'para #1 -- #2 até #3 faça'
\algnewcommand\algorithmicto{\textbf{at{\'e}}}
\algrenewtext{For}[3]%
{\algorithmicfor\ #1 $\gets$ #2 \algorithmicto\ #3 \algorithmicdo}


%================================================================================
% Comando para configurar os captions no documento
%================================================================================
\renewcommand{\ABNTEXfontereduzida}{\small} % Fonte reduzida para 11pt, conforme recomendação da USP
\DeclareCaptionFont{ABNTEXfontereduzida}{\ABNTEXfontereduzida}
\captionsetup{position=above, labelfont=ABNTEXfontereduzida, font=ABNTEXfontereduzida}

\DeclareCaptionFormat{listing}{\hrule height.8pt depth0pt #1#2#3}
\captionsetup[lstlisting]{format=listing,singlelinecheck=false, margin=0pt,labelsep=endash,labelfont=bf, font=normalsize}
\captionsetup[algorithm]{singlelinecheck=false, margin=0pt,labelsep=endash,labelfont=bf, font=normalsize}

%================================================================================
% Dedicatória
%================================================================================

% Comando para definição da dedicatória
\def\textodedicatoria{\@ifstar\@textodedicatoria\@@textodedicatoria}
% Inclui texto de um arquivo como dedicatória
\def\@textodedicatoria#1{\gdef\@dedicatoria{\input{#1}}} % \textodedicatoria*{}{} 
% Inclui o texto como dedicatória
\def\@@textodedicatoria#1{\gdef\@dedicatoria{#1}}       % \textodedicatoria{}{}

% Criação da dedicatória
\newcommand{\inserededicatoria}
{
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

% Comando para definição dos agradecimentos
\def\textoagradecimentos{\@ifstar\@textoagradecimentos\@@textoagradecimentos}
% Inclui texto de um arquivo como agradecimentos
\def\@textoagradecimentos#1{\gdef\@agradecimentos{\input{#1}}} % \textoagradecimentos*{}{}
% Inclui o texto como agradecimentos
\def\@@textoagradecimentos#1{\gdef\@agradecimentos{#1}} % \textoagradecimentos{}{}

% Criação dos agradecimentos
\newcommand{\insereagradecimentos}
{
  \@ifundefined{@agradecimentos}{}{
    \begin{agradecimentos}
      \@agradecimentos
    \end{agradecimentos}
  }
}

%================================================================================
% Epígrafe
%================================================================================

% Comando para definição da epígafe
\def\textoepigrafe{\@ifstar\@textoepigrafe\@@textoepigrafe}
% Inclui texto de um arquivo como epígafe
\def\@textoepigrafe#1{\gdef\@epigrafe{\input{#1}}}      % \textoepigrafe*{}{} 
% Inclui o texto como epígafe
\def\@@textoepigrafe#1{\gdef\@epigrafe{#1}}             % \textoepigrafe{}{}

% Criação da epígafe
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
% Lista de Símbolos
%================================================================================

% Comando para inserir simbolos na lista de símbolos
\newcommand{\simbolo}[2]{
  \addcontentsline{los}{simbolo}{\ensuremath{#1} --- #2}%
}

% Apresentação dos símbolos na lista de símbolos
\newcommand\l@simbolo[2]{\par #1}

% Criação da lista de símbolos
\newcommand{\inserelistadesimbolos}
{
  \@ifundefined{@incluilistadesimbolos}{}{
	 \pdfbookmark[0]{\listadesimbolosname}{listadesimbolos}
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

% Contador das palavras-chave
\newcounter{count}
% Enumera a lista de palavras-chave
\newcommand{\PROCESS}[1]{%
    \foreach\i in{#1}{%
\stepcounter{count}%
\arabic{count}.\enspace\i.\ %
    }%
}

\newcommand{\inserefichacatalografica}
{
    \@ifundefined{@arquivofichacatalografica}
    {
    
    % Captura a primeira letra do sobrenome do autor
    \expandafter\StrLeft\expandafter{\ABNTautordatabib}{1}[\firstletterauthor]
    % Captura a primeira letra do título
    \expandafter\StrLeft\expandafter{\thetitle}{1}[\firstlettertitle]
    
        \begin{fichacatalografica}
        	\vspace*{\fill}					% Posição vertical
 
	% Conteúdo
	\begin{otherlanguage}{brazil}
	\begin{tabular}{c|p{1.4cm}p{10.1cm}|}
	
	\multicolumn{3}{c}{\sffamily\small Ficha catalográfica elaborada pela Biblioteca Prof. Achille Bassi} \\
	\multicolumn{3}{c}{\sffamily\small e Seção Técnica de Informática, ICMC/USP,} \\
	\multicolumn{3}{c}{\sffamily\small com os dados fornecidos pelo(a) autor(a)} \\ \cline{2-3}
	& & \\
	& & \\
	& & {\fontsize{10.3pt}{1em}\selectfont\ttfamily\ABNTautordatabib} \\ 
	& {\fontsize{10.3pt}{1em}\selectfont\ttfamily \MakeUppercase{\firstletterauthor}\@codigocutter}\MakeLowercase{\firstlettertitle}%
	& {\fontsize{10.3pt}{1em}\selectfont\ttfamily~~~\imprimirtitulo\ / \imprimirautor; \MakeLowercase{\imprimirorientadorRotulo} \imprimirorientador \abntex@ifnotempty{\imprimircoorientador}{; \MakeLowercase{\imprimircoorientadorRotulo}~\imprimircoorientador}. -- \imprimirlocal, \@year.} \\ 
	& & {\fontsize{10.3pt}{1em}\selectfont\ttfamily~~~\pageref{LastPage} p.}\\
	& &\\
	& & {\fontsize{10.3pt}{1em}\selectfont\ttfamily~~~\imprimirtipotrabalho~(\tipodocurso~- \imprimirprograma) -- Instituto de Ciências Matemáticas e de Computação, Universidade de São Paulo, \@year.}\\
	& & \\ 
	& & {\fontsize{10.3pt}{1em}\selectfont\ttfamily~~~\expandafter\PROCESS\expandafter{\palavraschave}I. \ABNTorientadordatabib, orient.\ II.\ \abntex@ifnotempty{\imprimircoorientador}{%
	\ABNTcoorientadordatabib, coorient.\ III.\ }Título.} \\
	& & \\
	& & \\ \cline{2-3}
	%& & ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~CDU: 681.3.01:621.39 \\ \cline{2-3}
	
	\end{tabular}
	\end{otherlanguage}
	\vspace{1.5cm}

        \end{fichacatalografica}
    }{
        \begin{fichacatalografica}
            \includepdf{\@arquivofichacatalografica}
        \end{fichacatalografica}
    }
}


%================================================================================
% Resumo
%================================================================================

\newcommand{\xselectlanguage}[1]{\begingroup\edef\x{\endgroup\noexpand\selectlanguage{#1}}\x}
\newenvironment{xotherlanguage}[1]{%
  \begingroup%
  \edef\temp{\endgroup\noexpand\otherlanguage{#1}}%
  \temp%
  \ignorespaces%
}{\endotherlanguage\ignorespacesafterend}

\providecommand{\imprimirlanguage}{brazil}

% Criação do resumo e palavras chaves no documento
\newcommand{\insereresumo}
{

% Títulos do Resumo
\csdef{res-title-english}{Abstract}
\csdef{res-title-brazil}{Resumo}
\csdef{res-title-french}{Résumé}
\csdef{res-title-spanish}{Resumen}
% Labels: Palavras-chave
\csdef{res-label-keywords-english}{Keywords}
\csdef{res-label-keywords-brazil}{Palavras-chave}
\csdef{res-label-keywords-french}{Mots-clés}
\csdef{res-label-keywords-spanish}{Palabras clave}


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
                    \IfEndWith{\ABNTautorreferencia}{.}{\MakeUppercase{\ABNTautorreferencia}}{\MakeUppercase{\ABNTautorreferencia}.}
                    \foreignlanguage{\imprimirlanguage}{%
                        \textbf{\IfLangPortuguese{\imprimirtituloPT}{\imprimirtituloEN}}. %
                    }%
                    \@year. \pageref{LastPage} p. \imprimirtipotrabalho~(\tipodocurso~\imprimirespecialidade) -- Instituto de Ciências Matemáticas e de Computação, Universidade de S\~ao Paulo, \imprimirlocal, \@year.
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
% Definição de comandos a serem inseridos diretamente no início do documento
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
% INDICE REMISSIVO
%================================================================================

\makeindex

%================================================================================
% Configuração do modelo de capa exigido pelo programa do ICMC
%=============================================================================

% alterando a capa
\renewcommand{\imprimircapa}{%
  \begin{capa}%
    \center
    ~\\
    \vspace{7.1cm}
    \begin{minipage}{14.8cm}
    \center
    \rule{\textwidth}{1pt} \\
    \vspace{8mm}
    \begin{Spacing}{1.5}
        {\@icmcTitulo\nohyphens{\imprimirtitulo}} \\
    \end{Spacing}
    \vspace{8mm}
    {\@icmcAutorCapa\nohyphens{\imprimirautor}} \\
    \vspace{5mm}
    \rule{\textwidth}{1pt} \\
    \end{minipage}%
    ~\\
  \end{capa}
}

% folha de rosto
\newboolean{carimbo-folha-rosto}
\setboolean{carimbo-folha-rosto}{true}
\renewcommand{\folhaderostocontent}{

\vspace*{-6.2mm}
\ifthenelse{\boolean{carimbo-folha-rosto}}
    {
        \makebox[14.9cm][r]{\fbox{\parbox{7.2cm}{
        \vspace{0.3cm}
        \makebox[\linewidth][c]{\@icmcSVPG{SERVIÇO DE PÓS-GRADUAÇÃO DO ICMC-USP}}
          
          {
              \@icmcCarimbo
              \vspace{12pt}
              \hspace{2pt} Data de Depósito:
              
              \vspace{9pt}
              \hspace{2pt} Assinatura: \_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_
              \vspace{9pt}
          }
        }}}
    }
    {\vspace{2.95cm}}
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
%\vspace{\fill}
%\vspace{\fill}

{\@icmcLocalData
\imprimiruniversidade~-- São Carlos\\ 
\IfLangPortuguese
    {\Monthname[\@month] de \@year\\}
    {\Monthname[\@month]~\@year\\}
}
\vspace*{1.2cm}
\end{center}

} %folha de rosto

%================================================================================
% Configuração dos Estilo dos Capítulo
%================================================================================


\makechapterstyle{icmc}{%
  \renewcommand{\chapterheadstart}{} 
  
    % Secao secundaria (Section) Caixa baixa, Negrito
    \renewcommand*{\cftsectionfont}{\bfseries}
    % Secao terciaria (Subsection) Caixa baixa, Negrito, italico
    \renewcommand*{\cftsubsectionfont}{\itshape\bfseries}
    % Secao quaternaria (Subsubsection) Caixa baixa, italico
    \renewcommand*{\cftsubsubsectionfont}{\itshape}
    % Secao quinquenária (Subsubsubsection) Caixa baixa
    \renewcommand*{\cftparagraphfont}{\normalsize}


  % tamanhos de fontes de chapter e part	
   \ifthenelse{\equal{\ABNTEXisarticle}{true}}{%
     \setlength\beforechapskip{\baselineskip}
     \renewcommand{\chaptitlefont}{\ABNTEXsectionfont\ABNTEXsectionfontsize}
   }{%else
     \setlength{\beforechapskip}{0pt}
     \renewcommand{\ABNTEXchapterfontsize}{\LARGE}
    
    %\renewcommand{\ABNTEXchapterfont}{\sffamily\bfseries}  %alteração da fonte dos capítulos, seções e subseções
    \renewcommand{\chaptitlefont}{\ABNTEXchapterfont\bfseries\ABNTEXchapterfontsize}
   }
  
  \renewcommand{\chapnumfont}{\chaptitlefont}
  \renewcommand{\parttitlefont}{\ABNTEXpartfont\ABNTEXpartfontsize}
  \renewcommand{\partnumfont}{\ABNTEXpartfont\ABNTEXpartfontsize}
  \renewcommand{\partnamefont}{\ABNTEXpartfont\ABNTEXpartfontsize}
  
  % tamanhos de fontes de section, subsection, subsubsection e subsubsubsection
  \setsecheadstyle{\ABNTEXsectionfont\ABNTEXsectionfontsize\bfseries\ABNTEXsectionupperifneeded}
  \setsubsecheadstyle{\ABNTEXsubsectionfont\ABNTEXsubsectionfontsize\bfseries\itshape\ABNTEXsubsectionupperifneeded}
  \setsubsubsecheadstyle{\ABNTEXsubsubsectionfont\ABNTEXsubsubsectionfontsize\itshape\ABNTEXsubsubsectionupperifneeded}
  \setsubsubsubsecheadstyle{\ABNTEXsubsubsubsectionfont\ABNTEXsubsubsubsectionfontsize\ABNTEXsubsubsubsectionupperifneeded}
 
  % impressao do numero do capitulo
  \renewcommand{\chapternamenum}{}
  
  % impressao do nome do capitulo
  \renewcommand{\printchaptername}{%
   %\chaptitlefont
   %\ifthenelse{\boolean{abntex@apendiceousecao}}{\appendixname}{\chaptername}%
  }
    
  % impressao do titulo do capitulo
  \def\printchaptertitle##1{%
    
    \setboolean{ABNTEXupperchapter}{true}
    
    \ifthenelse{\boolean{abntex@innonumchapter}}{
        \vskip 0ex \hrulefill\chaptitlefont\bfseries\ABNTEXchapterupperifneeded{##1}
        \vskip -0.6ex\hfill\rule{.8\textwidth}{0.5pt} 
        \vskip -2.8ex\hfill\rule{.8\textwidth}{2pt}
        \vskip 1.5ex
    
    }{%
    % else
        {\hrulefill
        {\renewcommand{\arraystretch}{1.5} %  1 is the default, change whatever you need
        \begin{tabular}{|c|}
            \rowcolor{black}\color{white}\normalsize\ABNTEXchapterfont
              \ifthenelse{\boolean{abntex@apendiceousecao}}{\MakeTextUppercase{\appendixname}}{\MakeTextUppercase{\chaptername}}  \\ 
            \vspace{-1.5ex}\\ %coloquei para aumentar o espaço entre o título e o número
            \resizebox{!}{1.1cm}{\ABNTEXchapterfont\thechapter}
            \\[2.5ex]
            \hline
        \end{tabular}}} \\
        \vskip 4.3ex \flushright\chaptitlefont\bfseries\ABNTEXchapterupperifneeded{##1} \\
        \vskip -0.6ex\hfill\rule{.8\textwidth}{0.5pt} \\
        \vskip -2.8ex\hfill\rule{.8\textwidth}{2pt}\\
        \vskip 1.5ex
	}    
        
  }
       
  % impressao do numero do capitulo     	
  \renewcommand{\printchapternum}{%
    \setboolean{abntex@innonumchapter}{false}
  }
  \renewcommand{\afterchapternum}{}
  
  % impressao do capitulo nao numerado
  \renewcommand\printchapternonum{%
     \setboolean{abntex@innonumchapter}{true}%
    }
}
\chapterstyle{icmc}

%================================================================================
% Configurações ao iniciar documento
%================================================================================
\AtBeginDocument{

% Centraliza o caption das tabelas do IBGE, conforme recomendação da USP
\renewcommand{\configurecaptions}{\captionstyle[singlelinecheck=on]{}}

% suporte a alguns sequências comuns do LaTeX, como -- para travessão
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
    \imprimircapa

    % Folha de rosto e Ficha catalográfica (se houver)
    \ifthenelse{\boolean{opt-fichacatalografica}}{
        % (o * indica que haverá a ficha bibliográfica)
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
    
    %\renewcommand{\rmdefault}{cmr}

    % DEDICATÓRIA / AGRADECIMENTO / EPÍGRAFE
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
    
    % Configuração dos caracteres especiais utilizados no pacote <listings>
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
    
    % Numeração contínua do elementos do presentes no documento
    \counterwithout{quadro}{chapter}
    \counterwithout{lstlisting}{chapter}
    
    \mainmatter

    % Retira espaço extra obsoleto entre as frases.
    \frenchspacing
    
    \IfLangPortuguese{}{
        \bibliographystyle{packages/abntexalfenglish}
    }
}

% Finaliza comandos com @ no nome
\makeatother