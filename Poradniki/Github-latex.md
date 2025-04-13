# PORADNIK: Przesyłanie rozwiązań w LaTeX przez GitHub i VS Code

Ten przewodnik przeprowadzi Cię przez proces dodawania rozwiązań w LaTeX do naszego repozytorium przy użyciu GitHub i Visual Studio Code. Postępując zgodnie z tymi krokami, nauczysz się profesjonalnego przepływu pracy, który jest powszechnie stosowany zarówno w środowisku akademickim, jak i w branży IT.

## Spis treści
- [Konfiguracja środowiska](#konfiguracja-środowiska)
- [Pobieranie repozytorium](#pobieranie-repozytorium)
- [Praca z LaTeX w VS Code](#praca-z-latex-w-vs-code)
- [Wprowadzanie zmian w repozytorium](#wprowadzanie-zmian-w-repozytorium)
- [Tworzenie Pull Request](#tworzenie-pull-request)
- [Dobre praktyki w LaTeX](#dobre-praktyki-w-latex)
- [Typowe problemy i rozwiązania](#typowe-problemy-i-rozwiązania)

## Konfiguracja środowiska

### 1. Instalacja wymaganego oprogramowania

- **Git**: [Pobierz i zainstaluj Git](https://git-scm.com/downloads)
- **Visual Studio Code**: [Pobierz i zainstaluj VS Code](https://code.visualstudio.com/)
- **Dystrybucja LaTeX**:
  - Windows: [MiKTeX](https://miktex.org/download) lub [TeX Live](https://tug.org/texlive/acquire-netinstall.html)
  - macOS: [MacTeX](https://tug.org/mactex/mactex-download.html)
  - Linux: TeX Live (`sudo apt-get install texlive-full` dla Ubuntu/Debian)

### 2. Instalacja rozszerzeń VS Code

Otwórz VS Code i zainstaluj następujące rozszerzenia:

- **LaTeX Workshop**: Do edycji, kompilacji i podglądu LaTeX
- **GitHub Pull Requests and Issues**: Do integracji z GitHub
- **GitLens**: Dla rozszerzonych funkcji Git (opcjonalnie, ale zalecane)

Aby zainstalować rozszerzenia, kliknij ikonę Rozszerzenia na pasku aktywności lub naciśnij `Ctrl+Shift+X` (Windows/Linux) lub `Cmd+Shift+X` (macOS), następnie wyszukaj nazwę rozszerzenia i kliknij "Zainstaluj".

### 3. Konfiguracja Git

Otwórz terminal lub wiersz poleceń i skonfiguruj swoją tożsamość Git:

```bash
git config --global user.name "Twoje Imię i Nazwisko"
git config --global user.email "twoj.email@example.com"
```

## Pobieranie repozytorium

### 1. Forkowanie repozytorium

1. Przejdź do głównej strony repozytorium na GitHub
2. Kliknij przycisk "Fork" w prawym górnym rogu
3. Utworzy to kopię repozytorium na Twoim koncie GitHub

### 2. Klonowanie forka

1. Na stronie Twojego forka, kliknij przycisk "Code" i skopiuj URL
2. Otwórz VS Code
3. Naciśnij `Ctrl+Shift+P` (Windows/Linux) lub `Cmd+Shift+P` (macOS), aby otworzyć paletę poleceń
4. Wpisz "Git: Clone" i wybierz tę opcję
5. Wklej skopiowany URL i wybierz lokalny folder do przechowywania repozytorium
6. Kliknij "Otwórz", gdy zostaniesz poproszony o otwarcie sklonowanego repozytorium

### 3. Konfiguracja zdalnego repozytorium

Aby utrzymać swojego forka w synchronizacji z oryginalnym repozytorium, skonfiguruj zdalne repozytorium "upstream":

1. Otwórz terminal w VS Code, naciskając ``Ctrl+` `` (Windows/Linux) lub ``Cmd+` `` (macOS)
2. Uruchom następujące polecenia:

```bash
git remote add upstream https://github.com/original-owner/original-repository.git
git fetch upstream
```

## Praca z LaTeX w VS Code

### 1. Konfiguracja rozszerzenia LaTeX Workshop

LaTeX Workshop powinien automatycznie wykryć Twoją instalację LaTeX. Aby zweryfikować i dostosować ustawienia:

1. Przejdź do Plik > Preferencje > Ustawienia (lub naciśnij `Ctrl+,`)
2. Wyszukaj "latex-workshop", aby zobaczyć wszystkie dostępne ustawienia
3. Zalecane ustawienia:
   - Włącz "latex-workshop.latex.autoBuild.run" dla automatycznej kompilacji
   - Ustaw "latex-workshop.view.pdf.viewer" na "tab" dla zintegrowanego podglądu PDF

### 2. Korzystanie z pliku Makefile

Ten projekt zawiera plik Makefile, który automatyzuje proces kompilacji LaTeX. Jest to szczególnie przydatne do zapewnienia prawidłowego generowania odnośników, spisu treści i innych elementów, które wymagają wielokrotnej kompilacji.

#### Zrozumienie pliku Makefile
```makefile
# Makefile do kompilacji dokumentu LaTeX
# Zmienne
DOCUMENT = Tutorials
TEX_FILE = $(DOCUMENT).tex
PDF_FILE = $(DOCUMENT).pdf
# Domyślny cel
all: $(PDF_FILE)
# Reguła budowania PDF z TEX
$(PDF_FILE): $(TEX_FILE)
	pdflatex $(TEX_FILE)
	pdflatex $(TEX_FILE)  # Uruchom dwa razy dla odnośników
	pdflatex $(TEX_FILE)  # Standardowo uruchamia się trzy razy
# Czyszczenie plików tymczasowych
clean:
	rm -f *.aux *.log *.out *.toc *.lof *.lot *.bbl *.blg *.fls *.fdb_latexmk *.synctex.gz
# Usuń również PDF
cleanall: clean
	rm -f $(PDF_FILE)
# Cele ficyjne
.PHONY: all clean cleanall
```

#### Używanie pliku Makefile

Aby użyć pliku Makefile z wiersza poleceń w VS Code:

1. Otwórz terminal w VS Code (``Ctrl+` ``)
2. Uruchom jedno z tych poleceń:
   - `make` lub `make all` - Kompiluje dokument LaTeX (uruchamia pdflatex trzy razy)
   - `make clean` - Usuwa wszystkie pliki tymczasowe wygenerowane podczas kompilacji
   - `make cleanall` - Usuwa pliki tymczasowe i końcowy plik PDF

Plik Makefile uruchamia pdflatex trzy razy, aby zapewnić, że wszystkie odnośniki, spis treści i odniesienia krzyżowe są poprawnie rozwiązane.

### 3. Struktura plików LaTeX

Repozytorium ma określoną strukturę dla przesyłania rozwiązań w LaTeX. Każde rozwiązanie powinno być zgodne z tym formatem:

```latex
\begin{mdframed}
    % Twoje rozwiązanie tutaj
    % Dołącz swoje imię i nazwisko w komentarzu na początku
    % Przykład:
    % Rozwiązanie: Twoje Imię i Nazwisko
    
    Rozwiązanie:
    Dla części (a), zauważamy, że...
\end{mdframed}
```

### 4. Kompilacja dokumentów LaTeX

- Aby skompilować bieżący plik LaTeX: Naciśnij `Ctrl+Alt+B` lub użyj paska bocznego LaTeX Workshop
- Aby wyświetlić skompilowany PDF: Naciśnij `Ctrl+Alt+V` lub kliknij przycisk "View PDF" w pasku bocznym LaTeX Workshop
- Aby wyczyścić pliki pomocnicze: Użyj przycisku "Clean up auxiliary files" w pasku bocznym LaTeX Workshop

## Wprowadzanie zmian w repozytorium

### 1. Tworzenie nowej gałęzi

Zawsze twórz nową gałąź, pracując nad swoim rozwiązaniem:

1. W VS Code kliknij nazwę bieżącej gałęzi na pasku stanu (lewy dolny róg)
2. Kliknij "Create new branch..." i nadaj jej opisową nazwę (np. `rozwiazanie-zadanie-1-2-twojaimienazwisko`)
3. Wybierz "Create Branch"

### 2. Dodawanie rozwiązania

1. Przejdź do odpowiedniej sekcji w dokumencie LaTeX
2. Dodaj swoje rozwiązanie wewnątrz środowiska `\begin{mdframed}...\end{mdframed}`
3. Dołącz swoje imię i nazwisko w komentarzu na początku rozwiązania

### 3. Zatwierdzanie zmian (commit)

1. Zapisz swój plik (`Ctrl+S`)
2. Przejdź do zakładki Source Control w VS Code (lub naciśnij `Ctrl+Shift+G`)
3. Przygotuj swoje zmiany, klikając "+" obok zmodyfikowanego pliku
4. Wprowadź znaczący komunikat commit (np. "Dodaj rozwiązanie dla Zadania 1.2")
5. Kliknij znaczek zatwierdzenia, aby wykonać commit

### 4. Wysyłanie zmian (push)

1. Kliknij menu "..." w panelu Source Control
2. Wybierz "Push" lub "Publish Branch", jeśli to nowa gałąź
3. Twoje zmiany są teraz wysłane do Twojego forka na GitHub

## Tworzenie Pull Request

### 1. Przejdź do GitHub

1. Przejdź do swojego forka repozytorium na GitHub
2. GitHub może wyświetlić baner sugerujący utworzenie pull request z Twojej niedawno wysłanej gałęzi. Jeśli nie, kliknij "Pull requests", a następnie "New pull request"

### 2. Konfiguracja Pull Request

1. Upewnij się, że bazowe repozytorium to oryginalne repozytorium, a bazowa gałąź to `main`
2. Upewnij się, że repozytorium head to Twój fork, a gałąź porównawcza to Twoja nowa gałąź
3. Kliknij "Create pull request"

### 3. Wypełnianie szczegółów Pull Request

1. Nadaj swojemu pull request opisowy tytuł (np. "Rozwiązanie dla Zadania 1.2")
2. W opisie krótko wyjaśnij swoje podejście do rozwiązania
3. Wspomnij, którego numeru zadania dotyczy Twoje rozwiązanie
4. Kliknij "Create pull request"

### 4. Odpowiadanie na informacje zwrotne

1. Prowadzący lub inni studenci mogą przekazać informacje zwrotne na temat Twojego pull request
2. Aby uwzględnić informacje zwrotne, po prostu wprowadź dodatkowe zmiany w swoich plikach w VS Code
3. Zatwierdź i wyślij te zmiany do tej samej gałęzi
4. Automatycznie pojawią się one w pull request

## Dobre praktyki w LaTeX

### 1. Notacja matematyczna

Używaj odpowiednich środowisk i poleceń dla treści matematycznych:

- Matematyka w linii: `$x^2 + y^2 = z^2$`
- Matematyka wyświetlana: `\[ x^2 + y^2 = z^2 \]` lub 
  ```latex
  \begin{equation}
    x^2 + y^2 = z^2
  \end{equation}
  ```
- Wyrównanie wielu równań:
  ```latex
  \begin{align}
    a &= b + c \\
    &= d + e
  \end{align}
  ```

### 2. Korzystanie z predefiniowanych makr

Szablon zawiera kilka przydatnych makr:

- `\R` dla zbioru liczb rzeczywistych (wyświetla się jako ℝ)
- `\N` dla zbioru liczb naturalnych (wyświetla się jako ℕ)
- `\Z` dla zbioru liczb całkowitych (wyświetla się jako ℤ)
- `\C` dla zbioru liczb zespolonych (wyświetla się jako ℂ)

### 3. Wytyczne dotyczące formatowania

- Używaj odpowiedniego wcięcia dla lepszej czytelności
- Łam długie równania w odpowiednich miejscach
- Używaj środowisk `enumerate` lub `itemize` dla list
- Dołączaj wyjaśniający tekst między wyrażeniami matematycznymi

### 4. Obrazy i diagramy

Jeśli Twoje rozwiązanie zawiera diagramy:

1. Umieść pliki obrazów w katalogu `images`
2. Odwołuj się do nich za pomocą:
   ```latex
   \includegraphics[width=0.7\textwidth]{images/twoj-diagram.png}
   ```
3. W przypadku prostych diagramów rozważ użycie pakietu TikZ bezpośrednio w kodzie LaTeX

## Typowe problemy i rozwiązania

### Błędy kompilacji LaTeX

- **Brakujące pakiety**: Użyj `\usepackage{nazwa-pakietu}` na początku dokumentu
- **Niezdefiniowana sekwencja kontrolna**: Sprawdź literówki w nazwach poleceń
- **Brakujące nawiasy**: Upewnij się, że wszystkie otwierające nawiasy `{` mają pasujące nawiasy zamykające `}`

### Problemy z Git i GitHub

- **Nie można wysłać do repozytorium**: Upewnij się, że pracujesz na swoim forku, a nie na oryginalnym repozytorium
- **Konflikty scalania**: Jeśli napotkasz konflikty scalania, skorzystaj z wbudowanego narzędzia VS Code do rozwiązywania konfliktów scalania
- **Pull request pokazuje niezwiązane zmiany**: Upewnij się, że pracujesz na czystej gałęzi opartej na najnowszym upstream

### Problemy z VS Code

- **LaTeX Workshop nie kompiluje**: Sprawdź, czy Twoja dystrybucja LaTeX jest poprawnie zainstalowana i znajduje się w PATH
- **PDF nie aktualizuje się**: Spróbuj użyć "Clean up auxiliary files" i przebudować

## Uzyskiwanie pomocy

Jeśli napotkasz problemy, które nie zostały omówione w tym przewodniku:

1. Sprawdź zakładkę Issues repozytorium pod kątem podobnych problemów
2. Zapoznaj się z dokumentacją [LaTeX](https://www.latex-project.org/help/documentation/), [Git](https://git-scm.com/doc) lub [VS Code](https://code.visualstudio.com/docs)
3. Skontaktuj się z prowadzącym lub asystentami

---

Powodzenia z LaTeX i kodowaniem zespołowym!
