export interface WechatPlugin {
  isInstalled(): Promise<{ value: boolean }>;
  shareText(options: any): Promise<void>;
  shareLink(options: any): Promise<void>;
  shareImage(options: any): Promise<void>;
}
