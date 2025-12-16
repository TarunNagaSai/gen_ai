import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gen_ai/models/crypto_coin.dart';
import 'package:gen_ai/providers/crypto_provider.dart';
import 'package:gpt_markdown/gpt_markdown.dart';
import '../models/message.dart';
import 'package:intl/intl.dart';

class MessageBubble extends ConsumerStatefulWidget {
  final Message message;

  const MessageBubble({super.key, required this.message});

  @override
  ConsumerState<MessageBubble> createState() => _MessageBubbleState();
}

class _MessageBubbleState extends ConsumerState<MessageBubble> {
  @override
  Widget build(BuildContext context) {
    final isUser = widget.message.role == MessageRole.user;
    final theme = Theme.of(context);
    CryptoCoin? coin = ref.watch(cryptoProvider).selectedCoin;
    final chartColor = coin!.isPriceUp ? Colors.green : Colors.red;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        mainAxisAlignment: isUser
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isUser) ...[
            _buildAvatar(theme, isUser),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Column(
              crossAxisAlignment: isUser
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    gradient: isUser
                        ? LinearGradient(
                            colors: [
                              theme.colorScheme.primary,
                              theme.colorScheme.primaryContainer,
                            ],
                          )
                        : null,
                    color: isUser
                        ? null
                        : theme.colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(20),
                      topRight: const Radius.circular(20),
                      bottomLeft: Radius.circular(isUser ? 20 : 4),
                      bottomRight: Radius.circular(isUser ? 4 : 20),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Visibility(
                        visible: !isUser && coin != null,
                        child: SizedBox(
                          height: 100,
                          child: LineChart(
                            LineChartData(
                              gridData: const FlGridData(show: false),
                              titlesData: const FlTitlesData(show: false),
                              borderData: FlBorderData(show: false),
                              lineTouchData: const LineTouchData(
                                enabled: false,
                              ),
                              minX: 0,
                              maxX: coin!.sparklineData.length.toDouble() - 1,
                              minY: coin!.sparklineData.reduce(
                                (a, b) => a < b ? a : b,
                              ),
                              maxY: coin!.sparklineData.reduce(
                                (a, b) => a > b ? a : b,
                              ),
                              lineBarsData: [
                                LineChartBarData(
                                  spots: coin!.sparklineData
                                      .asMap()
                                      .entries
                                      .map(
                                        (e) =>
                                            FlSpot(e.key.toDouble(), e.value),
                                      )
                                      .toList(),
                                  isCurved: true,
                                  color: chartColor,
                                  barWidth: 2,
                                  isStrokeCapRound: true,
                                  dotData: const FlDotData(show: false),
                                  belowBarData: BarAreaData(
                                    show: true,
                                    color: chartColor.withOpacity(0.1),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      GptMarkdown(
                        widget.message.content,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: isUser
                              ? theme.colorScheme.onPrimary
                              : theme.colorScheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Text(
                    _formatTime(widget.message.timestamp),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurface.withOpacity(0.6),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (isUser) ...[
            const SizedBox(width: 8),
            _buildAvatar(theme, isUser),
          ],
        ],
      ),
    );
  }

  Widget _buildAvatar(ThemeData theme, bool isUser) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: isUser
            ? LinearGradient(
                colors: [
                  theme.colorScheme.primary,
                  theme.colorScheme.secondary,
                ],
              )
            : LinearGradient(
                colors: [
                  theme.colorScheme.tertiary,
                  theme.colorScheme.tertiaryContainer,
                ],
              ),
      ),
      child: Icon(
        isUser ? Icons.person : Icons.smart_toy,
        color: Colors.white,
        size: 20,
      ),
    );
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);

    if (difference.inDays > 0) {
      return DateFormat('MMM d, h:mm a').format(time);
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }
}
