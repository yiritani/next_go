#!/bin/bash

# エラーハンドリング: エラーが発生したらスクリプトを終了
set -e

# 変数の設定
PROJECT_ID="next-go-445113"
PROJECT_NUMBER="001"
WORKLOAD_IDENTITY_POOL="gha-pool"
WORKLOAD_IDENTITY_PROVIDER="gha-provider"
SERVICE_ACCOUNT_NAME="gha-sa"
GITHUB_REPO="next_go"

# ログ出力関数
log() {
    echo "[INFO] $1"
}

# IAM Credential API を有効化
if ! gcloud services list --enabled --filter="name:iamcredentials.googleapis.com" --format="value(name)" | grep "iamcredentials.googleapis.com" >/dev/null 2>&1; then
    log "IAM Credential API を有効にしています..."
    gcloud services enable iamcredentials.googleapis.com --project="$PROJECT_ID"
else
    log "IAM Credential API は既に有効化されています"
fi

# Workload Identity プールの作成
if ! gcloud iam workload-identity-pools describe $WORKLOAD_IDENTITY_POOL --location="global" --project="$PROJECT_ID" >/dev/null 2>&1; then
    log "Workload Identity プールを作成中: $WORKLOAD_IDENTITY_POOL"
    gcloud iam workload-identity-pools create $WORKLOAD_IDENTITY_POOL \
        --project="$PROJECT_ID" \
        --location="global" \
        --display-name="$WORKLOAD_IDENTITY_POOL"
else
    log "Workload Identity プールは既に存在します: $WORKLOAD_IDENTITY_POOL"
fi

# Workload Identity プロバイダの作成
if ! gcloud iam workload-identity-pools providers describe $WORKLOAD_IDENTITY_PROVIDER --workload-identity-pool="$WORKLOAD_IDENTITY_POOL" --location="global" --project="$PROJECT_ID" >/dev/null 2>&1; then
    log "Workload Identity プロバイダを作成中: $WORKLOAD_IDENTITY_PROVIDER"
    gcloud iam workload-identity-pools providers create-oidc $WORKLOAD_IDENTITY_PROVIDER \
        --project="$PROJECT_ID" \
        --location="global" \
        --workload-identity-pool="$WORKLOAD_IDENTITY_POOL" \
        --display-name="$WORKLOAD_IDENTITY_PROVIDER" \
        --issuer-uri="https://token.actions.githubusercontent.com" \
        --attribute-mapping="attribute.actor=assertion.actor,google.subject=assertion.sub,attribute.repository=assertion.repository" \
        --attribute-condition="assertion.repository=='${GITHUB_REPO}'"
else
    log "Workload Identity プロバイダは既に存在します: $WORKLOAD_IDENTITY_PROVIDER"
fi

# サービスアカウントの作成
if ! gcloud iam service-accounts describe $SERVICE_ACCOUNT_NAME@$PROJECT_ID.iam.gserviceaccount.com >/dev/null 2>&1; then
    log "サービスアカウントを作成中: $SERVICE_ACCOUNT_NAME"
    gcloud iam service-accounts create $SERVICE_ACCOUNT_NAME \
        --project="$PROJECT_ID" \
        --display-name="GitHub Actions Service Account"
else
    log "サービスアカウントは既に存在します: $SERVICE_ACCOUNT_NAME"
fi

# プロジェクトレベルでのロール付与
log "プロジェクトレベルでのロール付与の確認"
for role in "roles/owner" "roles/iam.workloadIdentityUser"; do
    if ! gcloud projects get-iam-policy $PROJECT_ID --flatten="bindings[].members" --filter="bindings.members:serviceAccount:$SERVICE_ACCOUNT_NAME@$PROJECT_ID.iam.gserviceaccount.com AND bindings.role:$role" --format="value(bindings.role)" | grep "$role" >/dev/null 2>&1; then
        log "$role をサービスアカウントに付与中: $SERVICE_ACCOUNT_NAME"
        gcloud projects add-iam-policy-binding $PROJECT_ID \
            --member="serviceAccount:$SERVICE_ACCOUNT_NAME@$PROJECT_ID.iam.gserviceaccount.com" \
            --role="$role"
    else
        log "$role は既にサービスアカウントに付与されています: $SERVICE_ACCOUNT_NAME"
    fi
done

log "Workload Identity 設定が完了しました。"
log "サービスアカウント: $SERVICE_ACCOUNT_NAME@$PROJECT_ID.iam.gserviceaccount.com"