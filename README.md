# PULSO — app de academia (Flutter)

Treino com ritmo. Projeto base do app PULSO, com a identidade visual e o
Design System definitivos já aplicados, arquitetura em camadas, Riverpod
para estado e Go Router para navegação.

Este pacote contém **apenas a tela de Login**, que é a rota inicial do
app. As demais telas serão adicionadas em etapas futuras sobre esta
mesma base.

## Stack

- Flutter (canal estável mais recente) + Dart >= 3.4
- Material Design 3
- Riverpod (`flutter_riverpod`) para gerenciamento de estado
- Go Router (`go_router`) para navegação
- Google Fonts (`google_fonts`) para a tipografia do Design System
- `http` — cliente preparado para a futura API própria

## Arquitetura

Camadas em sentido único de dependência:

```
presentation (screens, controllers)
      ↓ depende de
repositories (contratos + implementação)
      ↓ depende de
services (integração externa: auth, notificações, assinatura, API)
      ↓ depende de
models (estruturas de dados)
```

A UI nunca fala diretamente com um `Service`. Ela depende de um
`Repository` (interface), que por sua vez usa um `Service` (interface).
Isso significa que, para conectar Firebase, API própria ou Google Play
Billing, basta criar uma nova implementação da interface de serviço e
trocar o `Provider` correspondente em `lib/providers/` — nenhuma tela
precisa ser alterada.

## Estrutura de pastas

```
lib/
├── main.dart                          # entrada do app
├── app.dart                           # MaterialApp.router + tema
├── core/
│   ├── theme/                         # cores, tipografia, tema (DEFINITIVO)
│   ├── constants/                     # constantes globais
│   ├── errors/                        # exceptions (data) e failures (domínio)
│   ├── utils/                         # validators, helpers
│   └── network/                       # ApiClient, preparado para a API própria
├── routes/
│   ├── route_paths.dart               # paths centralizados
│   └── app_router.dart                # configuração do Go Router
├── models/                            # UserModel, SubscriptionModel
├── services/                          # contratos + mocks (auth, notificações, assinatura)
├── repositories/                      # contratos + implementação (auth)
├── providers/                         # providers Riverpod globais (services, repositories)
├── shared/
│   └── widgets/                       # componentes do Design System (DEFINITIVOS)
└── features/
    └── auth/
        └── presentation/
            ├── controllers/           # LoginController (StateNotifier)
            └── screens/                # LoginScreen

assets/
├── images/
├── icons/
└── fonts/
```

## Preparado para (interfaces já criadas, integração real pendente)

| Área | Onde está o contrato | Implementação atual | Próximo passo |
|---|---|---|---|
| Firebase Auth | `services/auth_service.dart` | `MockAuthService` | criar `FirebaseAuthService`, rodar `flutterfire configure`, trocar o provider em `providers/service_providers.dart` |
| Notificações push | `services/notification_service.dart` | `MockNotificationService` | adicionar `firebase_messaging`, criar `FirebaseNotificationService` |
| Assinatura Plus | `services/subscription_service.dart` + `models/subscription_model.dart` | `MockSubscriptionService` | adicionar `in_app_purchase`, criar `PlayBillingSubscriptionService` |
| API própria | `core/network/api_client.dart` | pronto, ainda não usado por nenhum serviço | apontar `AppConstants.apiBaseUrl` para o backend real |

Nenhuma dessas integrações foi implementada de fato — apenas a estrutura
que permite plugá-las sem refatorar a UI.

## Como rodar

Este pacote contém o código Dart (`lib/`), `pubspec.yaml` e
`analysis_options.yaml`. As pastas de plataforma (`android/`, `ios/`)
não estão incluídas — gere-as com o próprio Flutter, que cria os
arquivos nativos (incluindo binários do Gradle) corretamente para a
versão do seu SDK:

```bash
# 1. Descompacte este projeto em uma pasta, por exemplo pulso_app/
cd pulso_app

# 2. Gere as pastas de plataforma (não sobrescreve lib/ nem pubspec.yaml
#    existentes — o Flutter detecta e só adiciona o que falta)
flutter create --platforms=android --org com.pulso.app .

# 3. Baixe as dependências
flutter pub get

# 4. Rode em um dispositivo/emulador Android
flutter run
```

A tela de Login é exibida imediatamente — ela é a `initialLocation` do
`GoRouter` em `lib/routes/app_router.dart`.

## Convenções de código

- `flutter_lints` habilitado via `analysis_options.yaml`
- Widgets do Design System (`shared/widgets/`) são definitivos e não
  devem ser recriados — apenas reutilizados
- Toda nova tela deve declarar seu path em `routes/route_paths.dart` e
  sua rota em `routes/app_router.dart`
- Toda nova integração externa deve primeiro ganhar uma interface em
  `services/`, com uma implementação mock, antes da implementação real
