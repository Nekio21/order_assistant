# Order Assistant

## Opis projektu

Order Assistant to aplikacja Flutter, która umożliwia:

- Pobieranie i wyświetlanie produktów z [dummyjson.com](https://dummyjson.com/).
- Wklejanie tekstu (np. e-maili) i analizowanie go przez AI w celu zwrócenia listy pozycji (nazwa produktu i ilość).
- Dopasowanie pozycji do istniejących produktów; brak dopasowania jest wyraźnie oznaczony.
- Poprawne obliczanie sumy ilości oraz sumy całkowitej zamówienia.
- Dwa ekrany: **Produkty** i **Zamówienie**.
- Zastosowanie architektury **Clean Architecture + BLoC** do zarządzania stanem.
- Obsługę klucza AI z pliku konfiguracyjnego `.env`; brak lub niepoprawny klucz wyświetla czytelny komunikat i blokuje analizę.

---

## Konfiguracja klucza AI

1. Skopiuj plik `.env.example` do `.env` w głównym katalogu projektu:

```bash
cp .env.example .env
```

2. Otwórz .env i wpisz swój poprawny klucz AI:
   API_KEY=twój_poprawny_klucz

## Uruchomienie projektu

1. Pobierz wszystkie zależności:
     ```bash
      flutter pub get
    ```
2. Uruchom aplikację na emulatorze lub fizycznym urządzeniu:
    ```bash
      flutter run
    ```

## Po uruchomieniu

Na ekranie Produkty wyświetlają się produkty pobrane z API.

Na ekranie Zamówienie możesz wkleić tekst, który zostanie przeanalizowany przez AI i dopasowany do produktów.

W przypadku braku lub niepoprawnego klucza AI pojawi się komunikat i analiza nie zostanie wykonana.
