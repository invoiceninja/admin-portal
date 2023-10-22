// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/auth/auth_actions.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_actions_dialog.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class ViewTokenList implements PersistUI {
  ViewTokenList({
    this.force = false,
  });

  final bool force;
}

class ViewToken implements PersistUI, PersistPrefs {
  ViewToken({
    required this.tokenId,
    this.force = false,
  });

  final String? tokenId;
  final bool force;
}

class EditToken implements PersistUI, PersistPrefs {
  EditToken(
      {required this.token,
      this.completer,
      this.cancelCompleter,
      this.force = false});

  final TokenEntity token;
  final Completer? completer;
  final Completer? cancelCompleter;
  final bool force;
}

class UpdateToken implements PersistUI {
  UpdateToken(this.token);

  final TokenEntity token;
}

class LoadToken {
  LoadToken({this.completer, this.tokenId});

  final Completer? completer;
  final String? tokenId;
}

class LoadTokenActivity {
  LoadTokenActivity({this.completer, this.tokenId});

  final Completer? completer;
  final String? tokenId;
}

class LoadTokens {
  LoadTokens({this.completer});

  final Completer? completer;
}

class LoadTokenRequest implements StartLoading {}

class LoadTokenFailure implements StopLoading {
  LoadTokenFailure(this.error);

  final dynamic error;

  @override
  String toString() {
    return 'LoadTokenFailure{error: $error}';
  }
}

class LoadTokenSuccess implements StopLoading, PersistData {
  LoadTokenSuccess(this.token);

  final TokenEntity token;

  @override
  String toString() {
    return 'LoadTokenSuccess{token: $token}';
  }
}

class LoadTokensRequest implements StartLoading {}

class LoadTokensFailure implements StopLoading {
  LoadTokensFailure(this.error);

  final dynamic error;

  @override
  String toString() {
    return 'LoadTokensFailure{error: $error}';
  }
}

class LoadTokensSuccess implements StopLoading {
  LoadTokensSuccess(this.tokens);

  final BuiltList<TokenEntity> tokens;

  @override
  String toString() {
    return 'LoadTokensSuccess{tokens: $tokens}';
  }
}

class SaveTokenRequest implements StartSaving {
  SaveTokenRequest({
    required this.completer,
    required this.token,
    required this.password,
    required this.idToken,
  });

  final Completer completer;
  final TokenEntity? token;
  final String? password;
  final String? idToken;
}

class SaveTokenSuccess
    implements StopSaving, PersistData, PersistUI, UserVerifiedPassword {
  SaveTokenSuccess(this.token);

  final TokenEntity token;
}

class AddTokenSuccess
    implements StopSaving, PersistData, PersistUI, UserVerifiedPassword {
  AddTokenSuccess(this.token);

  final TokenEntity token;
}

class SaveTokenFailure implements StopSaving {
  SaveTokenFailure(this.error);

  final Object error;
}

class ArchiveTokensRequest implements StartSaving {
  ArchiveTokensRequest(this.completer, this.tokenIds);

  final Completer completer;
  final List<String> tokenIds;
}

class ArchiveTokensSuccess implements StopSaving, PersistData {
  ArchiveTokensSuccess(this.tokens);

  final List<TokenEntity> tokens;
}

class ArchiveTokensFailure implements StopSaving {
  ArchiveTokensFailure(this.tokens);

  final List<TokenEntity?> tokens;
}

class DeleteTokensRequest implements StartSaving {
  DeleteTokensRequest(this.completer, this.tokenIds);

  final Completer completer;
  final List<String> tokenIds;
}

class DeleteTokensSuccess implements StopSaving, PersistData {
  DeleteTokensSuccess(this.tokens);

  final List<TokenEntity> tokens;
}

class DeleteTokensFailure implements StopSaving {
  DeleteTokensFailure(this.tokens);

  final List<TokenEntity?> tokens;
}

class RestoreTokensRequest implements StartSaving {
  RestoreTokensRequest(this.completer, this.tokenIds);

  final Completer completer;
  final List<String> tokenIds;
}

class RestoreTokensSuccess implements StopSaving, PersistData {
  RestoreTokensSuccess(this.tokens);

  final List<TokenEntity> tokens;
}

class RestoreTokensFailure implements StopSaving {
  RestoreTokensFailure(this.tokens);

  final List<TokenEntity?> tokens;
}

class FilterTokens implements PersistUI {
  FilterTokens(this.filter);

  final String? filter;
}

class SortTokens implements PersistUI, PersistPrefs {
  SortTokens(this.field);

  final String field;
}

class FilterTokensByState implements PersistUI {
  FilterTokensByState(this.state);

  final EntityState state;
}

class FilterTokensByCustom1 implements PersistUI {
  FilterTokensByCustom1(this.value);

  final String value;
}

class FilterTokensByCustom2 implements PersistUI {
  FilterTokensByCustom2(this.value);

  final String value;
}

class FilterTokensByCustom3 implements PersistUI {
  FilterTokensByCustom3(this.value);

  final String value;
}

class FilterTokensByCustom4 implements PersistUI {
  FilterTokensByCustom4(this.value);

  final String value;
}

void handleTokenAction(
    BuildContext? context, List<BaseEntity> tokens, EntityAction? action) {
  if (tokens.isEmpty) {
    return;
  }

  final store = StoreProvider.of<AppState>(context!);
  final localization = AppLocalization.of(context);
  final token = tokens.first as TokenEntity;
  final tokenIds = tokens.map((token) => token.id).toList();

  switch (action) {
    case EntityAction.copy:
      Clipboard.setData(ClipboardData(text: token.token));
      showToast(localization!.copiedToClipboard.replaceFirst(':value ', ''));
      break;
    case EntityAction.edit:
      editEntity(entity: token);
      break;
    case EntityAction.restore:
      final message = tokenIds.length > 1
          ? localization!.restoredTokens
              .replaceFirst(':value', ':count')
              .replaceFirst(':count', tokenIds.length.toString())
          : localization!.restoredToken;
      store.dispatch(
          RestoreTokensRequest(snackBarCompleter<Null>(message), tokenIds));
      break;
    case EntityAction.archive:
      final message = tokenIds.length > 1
          ? localization!.archivedTokens
              .replaceFirst(':value', ':count')
              .replaceFirst(':count', tokenIds.length.toString())
          : localization!.archivedToken;
      store.dispatch(
          ArchiveTokensRequest(snackBarCompleter<Null>(message), tokenIds));
      break;
    case EntityAction.delete:
      final message = tokenIds.length > 1
          ? localization!.deletedTokens
              .replaceFirst(':value', ':count')
              .replaceFirst(':count', tokenIds.length.toString())
          : localization!.deletedToken;
      store.dispatch(
          DeleteTokensRequest(snackBarCompleter<Null>(message), tokenIds));
      break;
    case EntityAction.toggleMultiselect:
      if (!store.state.tokenListState.isInMultiselect()) {
        store.dispatch(StartTokenMultiselect());
      }

      if (tokens.isEmpty) {
        break;
      }

      for (final token in tokens) {
        if (!store.state.tokenListState.isSelected(token.id)) {
          store.dispatch(AddToTokenMultiselect(entity: token));
        } else {
          store.dispatch(RemoveFromTokenMultiselect(entity: token));
        }
      }
      break;
    case EntityAction.more:
      showEntityActionsDialog(
        entities: [token],
      );
      break;
  }
}

class StartTokenMultiselect {
  StartTokenMultiselect();
}

class AddToTokenMultiselect {
  AddToTokenMultiselect({required this.entity});

  final BaseEntity? entity;
}

class RemoveFromTokenMultiselect {
  RemoveFromTokenMultiselect({required this.entity});

  final BaseEntity? entity;
}

class ClearTokenMultiselect {
  ClearTokenMultiselect();
}
