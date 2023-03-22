import 'dart:convert';

import 'package:spimo/features/summary/domain/repository/summary_repository.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:http/http.dart' as http;

class OpenAISummaryRepository implements SummaryRepository {
  @override
  Future<String> createSummary({required List<String> memoList}) async {
    final message = '${memoList.join('。')}。';

    final response = await http.post(
      Uri.parse('https://api.openai.com/v1/chat/completions'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${dotenv.env['GPT_API_KEY']!}',
      },
      body: jsonEncode({
        "model": "gpt-3.5-turbo",
        "messages": [
          {"role": "system", "content": 'あなたは音声入力された文章を要約するのが上手な記者です'},
          {"role": "assistant", "content": message},
          {
            "role": "user",
            "content": 'この文章は音声入力により作成されたものです。変換間違いが含まれていることを考慮した上で要約してください。'
          },
        ]
      }),
      encoding: Encoding.getByName('utf-8'),
    );

    final responseData = jsonDecode(utf8.decode(response.bodyBytes));
    final result = responseData['choices'][0]['message']['content'];
    return result;
  }
}
