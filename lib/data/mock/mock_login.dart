const dynamic kMockLogin = '''
{
    "data": [
        {
            "permissions": "[]",
            "settings": "",
            "is_owner": true,
            "is_admin": true,
            "is_locked": false,
            "updated_at": null,
            "deleted_at": null,
            "user": {
                "id": "MVyb8mdvAZ",
                "first_name": "Demo",
                "last_name": "User",
                "email": "demo@example.com",
                "last_login": 1573645743,
                "updated_at": 1573645743,
                "deleted_at": null,
                "phone": "",
                "email_verified_at": null,
                "signature": ""
            },
             "company": {
                "id": "yJrb2KdWLD",
                "company_key": "rnrK2qYyitKPs9xxf78edGQxYhyeoLDKVvcwuqqw1ZLRpGXlxNPciocwxMavFqxe",
                "update_products": false,
                "fill_products": true,
                "convert_products": false,
                "custom_surcharge_taxes1": false,
                "custom_surcharge_taxes2": false,
                "custom_surcharge_taxes3": false,
                "custom_surcharge_taxes4": false,
                "enable_product_cost": false,
                "enable_product_quantity": true,
                "default_quantity": true,
                "custom_fields": "",
                "size_id": "",
                "industry_id": "",
                "first_month_of_year": "",
                "first_day_of_week": "",
                "settings": {
                    "auto_archive_invoice": false,
                    "lock_sent_invoices": false,
                    "enable_client_portal_tasks": false,
                    "enable_client_portal_password": false,
                    "enable_client_portal": true,
                    "enable_client_portal_dashboard": true,
                    "signature_on_pdf": false,
                    "document_email_attachment": false,
                    "send_portal_password": false,
                    "timezone_id": "15",
                    "date_format_id": "1",
                    "military_time": false,
                    "language_id": "1",
                    "show_currency_code": false,
                    "company_gateway_ids": "",
                    "currency_id": "1",
                    "custom_value1": "",
                    "custom_value2": "",
                    "custom_value3": "",
                    "custom_value4": "",
                    "default_task_rate": 0,
                    "payment_terms": 1,
                    "send_reminders": false,
                    "custom_message_dashboard": "",
                    "custom_message_unpaid_invoice": "",
                    "custom_message_paid_invoice": "",
                    "custom_message_unapproved_quote": "",
                    "auto_archive_quote": false,
                    "auto_convert_quote": false,
                    "inclusive_taxes": false,
                    "quote_footer": "",
                    "translations": {},
                    "counter_number_applied": "when_saved",
                    "invoice_number_pattern": "",
                    "invoice_number_counter": 1,
                    "invoice_number_prefix": "",
                    "quote_number_prefix": "",
                    "quote_number_pattern": "",
                    "quote_number_counter": 1,
                    "client_number_prefix": "",
                    "client_number_pattern": "",
                    "client_number_counter": 1,
                    "credit_number_prefix": "",
                    "credit_number_pattern": "",
                    "credit_number_counter": 1,
                    "task_number_prefix": "",
                    "task_number_pattern": "",
                    "task_number_counter": 1,
                    "expense_number_prefix": "",
                    "expense_number_pattern": "",
                    "expense_number_counter": 1,
                    "vendor_number_prefix": "",
                    "vendor_number_pattern": "",
                    "vendor_number_counter": 1,
                    "ticket_number_prefix": "",
                    "ticket_number_pattern": "",
                    "ticket_number_counter": 1,
                    "payment_number_prefix": "",
                    "payment_number_pattern": "",
                    "payment_number_counter": 1,
                    "shared_invoice_quote_counter": false,
                    "recurring_number_prefix": "R",
                    "reset_counter_frequency_id": "0",
                    "reset_counter_date": "",
                    "counter_padding": 4,
                    "design": "views\/pdf\/design1.blade.php",
                    "invoice_terms": "",
                    "quote_terms": "",
                    "invoice_taxes": 0,
                    "invoice_item_taxes": 0,
                    "invoice_design_id": "1",
                    "quote_design_id": "1",
                    "invoice_footer": "",
                    "invoice_labels": "",
                    "tax_name1": "",
                    "tax_rate1": 0,
                    "tax_name2": "",
                    "tax_rate2": 0,
                    "tax_name3": "",
                    "tax_rate3": 0,
                    "payment_type_id": "1",
                    "invoice_fields": "",
                    "show_accept_invoice_terms": false,
                    "show_accept_quote_terms": false,
                    "require_invoice_signature": false,
                    "require_quote_signature": false,
                    "reply_to_email": "",
                    "bcc_email": "",
                    "pdf_email_attachment": false,
                    "ubl_email_attachment": false,
                    "email_style": "",
                    "email_style_custom": "",
                    "email_subject_invoice": "",
                    "email_subject_quote": "",
                    "email_subject_payment": "",
                    "email_subject_statement": "",
                    "email_template_invoice": "",
                    "email_template_quote": "",
                    "email_template_payment": "",
                    "email_template_statement": "",
                    "email_subject_reminder1": "",
                    "email_subject_reminder2": "",
                    "email_subject_reminder3": "",
                    "email_subject_reminder_endless": "",
                    "email_template_reminder1": "",
                    "email_template_reminder2": "",
                    "email_template_reminder3": "",
                    "email_template_reminder_endless": "",
                    "email_signature": "",
                    "enable_email_markup": true,
                    "email_subject_custom1": "",
                    "email_subject_custom2": "",
                    "email_subject_custom3": "",
                    "email_template_custom1": "",
                    "email_template_custom2": "",
                    "email_template_custom3": "",
                    "enable_reminder1": false,
                    "enable_reminder2": false,
                    "enable_reminder3": false,
                    "num_days_reminder1": 0,
                    "num_days_reminder2": 0,
                    "num_days_reminder3": 0,
                    "schedule_reminder1": "",
                    "schedule_reminder2": "",
                    "schedule_reminder3": "",
                    "late_fee_amount1": 0,
                    "late_fee_amount2": 0,
                    "late_fee_amount3": 0,
                    "endless_reminder_frequency_id": "0",
                    "client_online_payment_notification": true,
                    "client_manual_payment_notification": true,
                    "name": "Demo Account",
                    "company_logo": "",
                    "website": "",
                    "address1": "",
                    "address2": "",
                    "city": "",
                    "state": "",
                    "postal_code": "",
                    "phone": "",
                    "email": "",
                    "country_id": "840",
                    "vat_number": "",
                    "id_number": "",
                    "page_size": "A4",
                    "font_size": 9,
                    "primary_font": "Roboto",
                    "secondary_font": "Roboto",
                    "hide_paid_to_date": false,
                    "embed_documents": false,
                    "all_pages_header": true,
                    "all_pages_footer": true
                },
                "updated_at": 1573641459,
                "deleted_at": 0,
                "users": [
                    {
                        "id": "MVyb8mdvAZ",
                        "first_name": "Demo",
                        "last_name": "User",
                        "email": "demo@example.com",
                        "last_login": 1573645743,
                        "updated_at": 1573645743,
                        "deleted_at": null,
                        "phone": "",
                        "email_verified_at": null,
                        "signature": ""
                    }
                ],
                "tax_rates": [],
                "groups": [
                   {
                    "id":"237123421",
                    "name":"Test Group",
                    "settings":{}                    
                   }
                ],
                "company_gateways": [
                ]
            },
            "token": {
                "token": "d2oWWAP4POflJAVLELCthSF5G94D0f3kRb0tjyF6uGY8LGgR1qIbJxffI8OwEHXS",
                "name": "Demo User"
            },
            "account": {
                "id": "O5xe7jd7rJ",
                "default_url": "",
                "plan": ""
            }
        }
    ],
     "meta": {
        "pagination": {
            "total": 1,
            "count": 1,
            "per_page": 20,
            "current_page": 1,
            "total_pages": 1,
            "links": []
        }
    },
    "static": {
        "countries": [
        ],
        "currencies": [
            {
                "id": "23",
                "name": "Argentine Peso",
                "symbol": "\$",
                "precision": "2",
                "thousand_separator": ".",
                "decimal_separator": ",",
                "code": "ARS",
                "swap_currency_symbol": false
            },
            {
                "id": "40",
                "name": "Aruban Florin",
                "symbol": "Afl. ",
                "precision": "2",
                "thousand_separator": " ",
                "decimal_separator": ".",
                "code": "AWG",
                "swap_currency_symbol": false
            },
            {
                "id": "12",
                "name": "Australian Dollar",
                "symbol": "\$",
                "precision": "2",
                "thousand_separator": ",",
                "decimal_separator": ".",
                "code": "AUD",
                "swap_currency_symbol": false
            },
            {
                "id": "77",
                "name": "Bahraini Dinar",
                "symbol": "BD ",
                "precision": "2",
                "thousand_separator": ",",
                "decimal_separator": ".",
                "code": "BHD",
                "swap_currency_symbol": false
            },
            {
                "id": "24",
                "name": "Bangladeshi Taka",
                "symbol": "Tk",
                "precision": "2",
                "thousand_separator": ",",
                "decimal_separator": ".",
                "code": "BDT",
                "swap_currency_symbol": false
            },
            {
                "id": "71",
                "name": "Barbadian Dollar",
                "symbol": "\$",
                "precision": "2",
                "thousand_separator": ",",
                "decimal_separator": ".",
                "code": "BBD",
                "swap_currency_symbol": false
            },
            {
                "id": "68",
                "name": "Botswana Pula",
                "symbol": "P",
                "precision": "2",
                "thousand_separator": ",",
                "decimal_separator": ".",
                "code": "BWP",
                "swap_currency_symbol": false
            },
            {
                "id": "20",
                "name": "Brazilian Real",
                "symbol": "R\$",
                "precision": "2",
                "thousand_separator": ".",
                "decimal_separator": ",",
                "code": "BRL",
                "swap_currency_symbol": false
            },
            {
                "id": "2",
                "name": "British Pound",
                "symbol": "\u00a3",
                "precision": "2",
                "thousand_separator": ",",
                "decimal_separator": ".",
                "code": "GBP",
                "swap_currency_symbol": false
            },
            {
                "id": "72",
                "name": "Brunei Dollar",
                "symbol": "B\$",
                "precision": "2",
                "thousand_separator": ",",
                "decimal_separator": ".",
                "code": "BND",
                "swap_currency_symbol": false
            },
            {
                "id": "39",
                "name": "Bulgarian Lev",
                "symbol": "",
                "precision": "2",
                "thousand_separator": " ",
                "decimal_separator": ".",
                "code": "BGN",
                "swap_currency_symbol": false
            },
            {
                "id": "9",
                "name": "Canadian Dollar",
                "symbol": "C\$",
                "precision": "2",
                "thousand_separator": ",",
                "decimal_separator": ".",
                "code": "CAD",
                "swap_currency_symbol": false
            },
            {
                "id": "62",
                "name": "Chilean Peso",
                "symbol": "\$",
                "precision": "0",
                "thousand_separator": ".",
                "decimal_separator": ",",
                "code": "CLP",
                "swap_currency_symbol": false
            },
            {
                "id": "32",
                "name": "Chinese Renminbi",
                "symbol": "RMB ",
                "precision": "2",
                "thousand_separator": ",",
                "decimal_separator": ".",
                "code": "CNY",
                "swap_currency_symbol": false
            },
            {
                "id": "30",
                "name": "Colombian Peso",
                "symbol": "\$",
                "precision": "2",
                "thousand_separator": ".",
                "decimal_separator": ",",
                "code": "COP",
                "swap_currency_symbol": false
            },
            {
                "id": "47",
                "name": "Costa Rican Col\u00f3n",
                "symbol": "",
                "precision": "2",
                "thousand_separator": ",",
                "decimal_separator": ".",
                "code": "CRC",
                "swap_currency_symbol": false
            },
            {
                "id": "43",
                "name": "Croatian Kuna",
                "symbol": "kn",
                "precision": "2",
                "thousand_separator": ".",
                "decimal_separator": ",",
                "code": "HRK",
                "swap_currency_symbol": false
            },
            {
                "id": "51",
                "name": "Czech Koruna",
                "symbol": "K\u010d",
                "precision": "2",
                "thousand_separator": " ",
                "decimal_separator": ",",
                "code": "CZK",
                "swap_currency_symbol": true
            },
            {
                "id": "5",
                "name": "Danish Krone",
                "symbol": "kr",
                "precision": "2",
                "thousand_separator": ".",
                "decimal_separator": ",",
                "code": "DKK",
                "swap_currency_symbol": true
            },
            {
                "id": "61",
                "name": "Dominican Peso",
                "symbol": "RD\$",
                "precision": "2",
                "thousand_separator": ",",
                "decimal_separator": ".",
                "code": "DOP",
                "swap_currency_symbol": false
            },
            {
                "id": "37",
                "name": "East Caribbean Dollar",
                "symbol": "EC\$",
                "precision": "2",
                "thousand_separator": ",",
                "decimal_separator": ".",
                "code": "XCD",
                "swap_currency_symbol": false
            },
            {
                "id": "29",
                "name": "Egyptian Pound",
                "symbol": "E\u00a3",
                "precision": "2",
                "thousand_separator": ",",
                "decimal_separator": ".",
                "code": "EGP",
                "swap_currency_symbol": false
            },
            {
                "id": "3",
                "name": "Euro",
                "symbol": "\u20ac",
                "precision": "2",
                "thousand_separator": ".",
                "decimal_separator": ",",
                "code": "EUR",
                "swap_currency_symbol": false
            },
            {
                "id": "73",
                "name": "Georgian Lari",
                "symbol": "",
                "precision": "2",
                "thousand_separator": " ",
                "decimal_separator": ",",
                "code": "GEL",
                "swap_currency_symbol": false
            },
            {
                "id": "38",
                "name": "Ghanaian Cedi",
                "symbol": "",
                "precision": "2",
                "thousand_separator": ",",
                "decimal_separator": ".",
                "code": "GHS",
                "swap_currency_symbol": false
            },
            {
                "id": "18",
                "name": "Guatemalan Quetzal",
                "symbol": "Q",
                "precision": "2",
                "thousand_separator": ",",
                "decimal_separator": ".",
                "code": "GTQ",
                "swap_currency_symbol": false
            },
            {
                "id": "75",
                "name": "Honduran Lempira",
                "symbol": "L",
                "precision": "2",
                "thousand_separator": ",",
                "decimal_separator": ".",
                "code": "HNL",
                "swap_currency_symbol": false
            },
            {
                "id": "26",
                "name": "Hong Kong Dollar",
                "symbol": "",
                "precision": "2",
                "thousand_separator": ",",
                "decimal_separator": ".",
                "code": "HKD",
                "swap_currency_symbol": false
            },
            {
                "id": "69",
                "name": "Hungarian Forint",
                "symbol": "Ft",
                "precision": "0",
                "thousand_separator": ".",
                "decimal_separator": ",",
                "code": "HUF",
                "swap_currency_symbol": true
            },
            {
                "id": "63",
                "name": "Icelandic Kr\u00f3na",
                "symbol": "kr",
                "precision": "2",
                "thousand_separator": ".",
                "decimal_separator": ",",
                "code": "ISK",
                "swap_currency_symbol": true
            },
            {
                "id": "11",
                "name": "Indian Rupee",
                "symbol": "Rs. ",
                "precision": "2",
                "thousand_separator": ",",
                "decimal_separator": ".",
                "code": "INR",
                "swap_currency_symbol": false
            },
            {
                "id": "27",
                "name": "Indonesian Rupiah",
                "symbol": "Rp",
                "precision": "2",
                "thousand_separator": ",",
                "decimal_separator": ".",
                "code": "IDR",
                "swap_currency_symbol": false
            },
            {
                "id": "6",
                "name": "Israeli Shekel",
                "symbol": "NIS ",
                "precision": "2",
                "thousand_separator": ",",
                "decimal_separator": ".",
                "code": "ILS",
                "swap_currency_symbol": false
            },
            {
                "id": "45",
                "name": "Japanese Yen",
                "symbol": "\u00a5",
                "precision": "0",
                "thousand_separator": ",",
                "decimal_separator": ".",
                "code": "JPY",
                "swap_currency_symbol": false
            },
            {
                "id": "65",
                "name": "Jordanian Dinar",
                "symbol": "",
                "precision": "2",
                "thousand_separator": ",",
                "decimal_separator": ".",
                "code": "JOD",
                "swap_currency_symbol": false
            },
            {
                "id": "8",
                "name": "Kenyan Shilling",
                "symbol": "KSh ",
                "precision": "2",
                "thousand_separator": ",",
                "decimal_separator": ".",
                "code": "KES",
                "swap_currency_symbol": false
            },
            {
                "id": "59",
                "name": "Macanese Pataca",
                "symbol": "MOP\$",
                "precision": "2",
                "thousand_separator": ",",
                "decimal_separator": ".",
                "code": "MOP",
                "swap_currency_symbol": false
            },
            {
                "id": "19",
                "name": "Malaysian Ringgit",
                "symbol": "RM",
                "precision": "2",
                "thousand_separator": ",",
                "decimal_separator": ".",
                "code": "MYR",
                "swap_currency_symbol": false
            },
            {
                "id": "46",
                "name": "Maldivian Rufiyaa",
                "symbol": "",
                "precision": "2",
                "thousand_separator": ",",
                "decimal_separator": ".",
                "code": "MVR",
                "swap_currency_symbol": false
            },
            {
                "id": "28",
                "name": "Mexican Peso",
                "symbol": "\$",
                "precision": "2",
                "thousand_separator": ",",
                "decimal_separator": ".",
                "code": "MXN",
                "swap_currency_symbol": false
            },
            {
                "id": "56",
                "name": "Mozambican Metical",
                "symbol": "MT",
                "precision": "2",
                "thousand_separator": ".",
                "decimal_separator": ",",
                "code": "MZN",
                "swap_currency_symbol": true
            },
            {
                "id": "66",
                "name": "Myanmar Kyat",
                "symbol": "K",
                "precision": "2",
                "thousand_separator": ",",
                "decimal_separator": ".",
                "code": "MMK",
                "swap_currency_symbol": false
            },
            {
                "id": "53",
                "name": "Namibian Dollar",
                "symbol": "\$",
                "precision": "2",
                "thousand_separator": ",",
                "decimal_separator": ".",
                "code": "NAD",
                "swap_currency_symbol": false
            },
            {
                "id": "35",
                "name": "Netherlands Antillean Guilder",
                "symbol": "",
                "precision": "2",
                "thousand_separator": ".",
                "decimal_separator": ",",
                "code": "ANG",
                "swap_currency_symbol": false
            },
            {
                "id": "15",
                "name": "New Zealand Dollar",
                "symbol": "\$",
                "precision": "2",
                "thousand_separator": ",",
                "decimal_separator": ".",
                "code": "NZD",
                "swap_currency_symbol": false
            },
            {
                "id": "22",
                "name": "Nigerian Naira",
                "symbol": "",
                "precision": "2",
                "thousand_separator": ",",
                "decimal_separator": ".",
                "code": "NGN",
                "swap_currency_symbol": false
            },
            {
                "id": "14",
                "name": "Norske Kroner",
                "symbol": "kr",
                "precision": "2",
                "thousand_separator": ".",
                "decimal_separator": ",",
                "code": "NOK",
                "swap_currency_symbol": true
            },
            {
                "id": "57",
                "name": "Omani Rial",
                "symbol": "",
                "precision": "2",
                "thousand_separator": ",",
                "decimal_separator": ".",
                "code": "OMR",
                "swap_currency_symbol": false
            },
            {
                "id": "48",
                "name": "Pakistani Rupee",
                "symbol": "Rs ",
                "precision": "0",
                "thousand_separator": ",",
                "decimal_separator": ".",
                "code": "PKR",
                "swap_currency_symbol": false
            },
            {
                "id": "64",
                "name": "Papua New Guinean Kina",
                "symbol": "K",
                "precision": "2",
                "thousand_separator": ",",
                "decimal_separator": ".",
                "code": "PGK",
                "swap_currency_symbol": false
            },
            {
                "id": "67",
                "name": "Peruvian Sol",
                "symbol": "S\/ ",
                "precision": "2",
                "thousand_separator": ",",
                "decimal_separator": ".",
                "code": "PEN",
                "swap_currency_symbol": false
            },
            {
                "id": "10",
                "name": "Philippine Peso",
                "symbol": "P ",
                "precision": "2",
                "thousand_separator": ",",
                "decimal_separator": ".",
                "code": "PHP",
                "swap_currency_symbol": false
            },
            {
                "id": "49",
                "name": "Polish Zloty",
                "symbol": "z\u0142",
                "precision": "2",
                "thousand_separator": " ",
                "decimal_separator": ",",
                "code": "PLN",
                "swap_currency_symbol": true
            },
            {
                "id": "74",
                "name": "Qatari Riyal",
                "symbol": "QR",
                "precision": "2",
                "thousand_separator": ",",
                "decimal_separator": ".",
                "code": "QAR",
                "swap_currency_symbol": false
            },
            {
                "id": "42",
                "name": "Romanian New Leu",
                "symbol": "",
                "precision": "2",
                "thousand_separator": ",",
                "decimal_separator": ".",
                "code": "RON",
                "swap_currency_symbol": false
            },
            {
                "id": "55",
                "name": "Russian Ruble",
                "symbol": "",
                "precision": "2",
                "thousand_separator": ",",
                "decimal_separator": ".",
                "code": "RUB",
                "swap_currency_symbol": false
            },
            {
                "id": "33",
                "name": "Rwandan Franc",
                "symbol": "RF ",
                "precision": "2",
                "thousand_separator": ",",
                "decimal_separator": ".",
                "code": "RWF",
                "swap_currency_symbol": false
            },
            {
                "id": "44",
                "name": "Saudi Riyal",
                "symbol": "",
                "precision": "2",
                "thousand_separator": ",",
                "decimal_separator": ".",
                "code": "SAR",
                "swap_currency_symbol": false
            },
            {
                "id": "13",
                "name": "Singapore Dollar",
                "symbol": "",
                "precision": "2",
                "thousand_separator": ",",
                "decimal_separator": ".",
                "code": "SGD",
                "swap_currency_symbol": false
            },
            {
                "id": "4",
                "name": "South African Rand",
                "symbol": "R",
                "precision": "2",
                "thousand_separator": ",",
                "decimal_separator": ".",
                "code": "ZAR",
                "swap_currency_symbol": false
            },
            {
                "id": "50",
                "name": "Sri Lankan Rupee",
                "symbol": "LKR",
                "precision": "2",
                "thousand_separator": ",",
                "decimal_separator": ".",
                "code": "LKR",
                "swap_currency_symbol": true
            },
            {
                "id": "76",
                "name": "Surinamese Dollar",
                "symbol": "SRD",
                "precision": "2",
                "thousand_separator": ".",
                "decimal_separator": ",",
                "code": "SRD",
                "swap_currency_symbol": false
            },
            {
                "id": "7",
                "name": "Swedish Krona",
                "symbol": "kr",
                "precision": "2",
                "thousand_separator": ".",
                "decimal_separator": ",",
                "code": "SEK",
                "swap_currency_symbol": true
            },
            {
                "id": "17",
                "name": "Swiss Franc",
                "symbol": "",
                "precision": "2",
                "thousand_separator": "'",
                "decimal_separator": ".",
                "code": "CHF",
                "swap_currency_symbol": false
            },
            {
                "id": "60",
                "name": "Taiwan New Dollar",
                "symbol": "NT\$",
                "precision": "2",
                "thousand_separator": ",",
                "decimal_separator": ".",
                "code": "TWD",
                "swap_currency_symbol": false
            },
            {
                "id": "34",
                "name": "Tanzanian Shilling",
                "symbol": "TSh ",
                "precision": "2",
                "thousand_separator": ",",
                "decimal_separator": ".",
                "code": "TZS",
                "swap_currency_symbol": false
            },
            {
                "id": "21",
                "name": "Thai Baht",
                "symbol": "",
                "precision": "2",
                "thousand_separator": ",",
                "decimal_separator": ".",
                "code": "THB",
                "swap_currency_symbol": false
            },
            {
                "id": "36",
                "name": "Trinidad and Tobago Dollar",
                "symbol": "TT\$",
                "precision": "2",
                "thousand_separator": ",",
                "decimal_separator": ".",
                "code": "TTD",
                "swap_currency_symbol": false
            },
            {
                "id": "54",
                "name": "Tunisian Dinar",
                "symbol": "",
                "precision": "2",
                "thousand_separator": ",",
                "decimal_separator": ".",
                "code": "TND",
                "swap_currency_symbol": false
            },
            {
                "id": "41",
                "name": "Turkish Lira",
                "symbol": "TL ",
                "precision": "2",
                "thousand_separator": ".",
                "decimal_separator": ",",
                "code": "TRY",
                "swap_currency_symbol": false
            },
            {
                "id": "1",
                "name": "US Dollar",
                "symbol": "\$",
                "precision": "2",
                "thousand_separator": ",",
                "decimal_separator": ".",
                "code": "USD",
                "swap_currency_symbol": false
            },
            {
                "id": "70",
                "name": "Ugandan Shilling",
                "symbol": "USh ",
                "precision": "2",
                "thousand_separator": ",",
                "decimal_separator": ".",
                "code": "UGX",
                "swap_currency_symbol": false
            },
            {
                "id": "58",
                "name": "Ukrainian Hryvnia",
                "symbol": "",
                "precision": "2",
                "thousand_separator": ",",
                "decimal_separator": ".",
                "code": "UAH",
                "swap_currency_symbol": false
            },
            {
                "id": "25",
                "name": "United Arab Emirates Dirham",
                "symbol": "DH ",
                "precision": "2",
                "thousand_separator": ",",
                "decimal_separator": ".",
                "code": "AED",
                "swap_currency_symbol": false
            },
            {
                "id": "52",
                "name": "Uruguayan Peso",
                "symbol": "\$",
                "precision": "2",
                "thousand_separator": ".",
                "decimal_separator": ",",
                "code": "UYU",
                "swap_currency_symbol": false
            },
            {
                "id": "78",
                "name": "Venezuelan Bolivars",
                "symbol": "Bs.",
                "precision": "2",
                "thousand_separator": ".",
                "decimal_separator": ",",
                "code": "VES",
                "swap_currency_symbol": false
            },
            {
                "id": "16",
                "name": "Vietnamese Dong",
                "symbol": "",
                "precision": "0",
                "thousand_separator": ".",
                "decimal_separator": ",",
                "code": "VND",
                "swap_currency_symbol": false
            },
            {
                "id": "31",
                "name": "West African Franc",
                "symbol": "CFA ",
                "precision": "2",
                "thousand_separator": ",",
                "decimal_separator": ".",
                "code": "XOF",
                "swap_currency_symbol": false
            },
            {
                "id": "79",
                "name": "texts.currency_south_korean_won",
                "symbol": "W ",
                "precision": "2",
                "thousand_separator": ".",
                "decimal_separator": ",",
                "code": "KRW",
                "swap_currency_symbol": false
            }
        ],
        "date_formats": [
            {
                "id": "1",
                "format": "d\/M\/Y",
                "format_moment": "DD\/MMM\/YYYY",
                "format_dart": "dd\/MMM\/yyyy"
            },
            {
                "id": "2",
                "format": "d-M-Y",
                "format_moment": "DD-MMM-YYYY",
                "format_dart": "dd-MMM-yyyy"
            },
            {
                "id": "3",
                "format": "d\/F\/Y",
                "format_moment": "DD\/MMMM\/YYYY",
                "format_dart": "dd\/MMMM\/yyyy"
            },
            {
                "id": "4",
                "format": "d-F-Y",
                "format_moment": "DD-MMMM-YYYY",
                "format_dart": "dd-MMMM-yyyy"
            },
            {
                "id": "5",
                "format": "M j, Y",
                "format_moment": "MMM D, YYYY",
                "format_dart": "MMM d, yyyy"
            },
            {
                "id": "6",
                "format": "F j, Y",
                "format_moment": "MMMM D, YYYY",
                "format_dart": "MMMM d, yyyy"
            },
            {
                "id": "7",
                "format": "D M j, Y",
                "format_moment": "ddd MMM Do, YYYY",
                "format_dart": "EEE MMM d, yyyy"
            },
            {
                "id": "8",
                "format": "Y-m-d",
                "format_moment": "YYYY-MM-DD",
                "format_dart": "yyyy-MM-dd"
            },
            {
                "id": "9",
                "format": "d-m-Y",
                "format_moment": "DD-MM-YYYY",
                "format_dart": "dd-MM-yyyy"
            },
            {
                "id": "10",
                "format": "m\/d\/Y",
                "format_moment": "MM\/DD\/YYYY",
                "format_dart": "MM\/dd\/yyyy"
            },
            {
                "id": "11",
                "format": "d.m.Y",
                "format_moment": "D.MM.YYYY",
                "format_dart": "dd.MM.yyyy"
            },
            {
                "id": "12",
                "format": "j. M. Y",
                "format_moment": "DD. MMM. YYYY",
                "format_dart": "d. MMM. yyyy"
            },
            {
                "id": "13",
                "format": "j. F Y",
                "format_moment": "DD. MMMM YYYY",
                "format_dart": "d. MMMM yyyy"
            }
        ],
        "datetime_formats": [
            {
                "id": "1",
                "format": "d\/M\/Y g:i a",
                "format_moment": "DD\/MMM\/YYYY h:mm:ss a",
                "format_dart": "dd\/MMM\/yyyy h:mm a"
            },
            {
                "id": "2",
                "format": "d-M-Y g:i a",
                "format_moment": "DD-MMM-YYYY h:mm:ss a",
                "format_dart": "dd-MMM-yyyy h:mm a"
            },
            {
                "id": "3",
                "format": "d\/F\/Y g:i a",
                "format_moment": "DD\/MMMM\/YYYY h:mm:ss a",
                "format_dart": "dd\/MMMM\/yyyy h:mm a"
            },
            {
                "id": "4",
                "format": "d-F-Y g:i a",
                "format_moment": "DD-MMMM-YYYY h:mm:ss a",
                "format_dart": "dd-MMMM-yyyy h:mm a"
            },
            {
                "id": "5",
                "format": "M j, Y g:i a",
                "format_moment": "MMM D, YYYY h:mm:ss a",
                "format_dart": "MMM d, yyyy h:mm a"
            },
            {
                "id": "6",
                "format": "F j, Y g:i a",
                "format_moment": "MMMM D, YYYY h:mm:ss a",
                "format_dart": "MMMM d, yyyy h:mm a"
            },
            {
                "id": "7",
                "format": "D M jS, Y g:i a",
                "format_moment": "ddd MMM Do, YYYY h:mm:ss a",
                "format_dart": "EEE MMM d, yyyy h:mm a"
            },
            {
                "id": "8",
                "format": "Y-m-d g:i a",
                "format_moment": "YYYY-MM-DD h:mm:ss a",
                "format_dart": "yyyy-MM-dd h:mm a"
            },
            {
                "id": "9",
                "format": "d-m-Y g:i a",
                "format_moment": "DD-MM-YYYY h:mm:ss a",
                "format_dart": "dd-MM-yyyy h:mm a"
            },
            {
                "id": "10",
                "format": "m\/d\/Y g:i a",
                "format_moment": "MM\/DD\/YYYY h:mm:ss a",
                "format_dart": "MM\/dd\/yyyy h:mm a"
            },
            {
                "id": "11",
                "format": "d.m.Y g:i a",
                "format_moment": "D.MM.YYYY h:mm:ss a",
                "format_dart": "dd.MM.yyyy h:mm a"
            },
            {
                "id": "12",
                "format": "j. M. Y g:i a",
                "format_moment": "DD. MMM. YYYY h:mm:ss a",
                "format_dart": "d. MMM. yyyy h:mm a"
            },
            {
                "id": "13",
                "format": "j. F Y g:i a",
                "format_moment": "DD. MMMM YYYY h:mm:ss a",
                "format_dart": "d. MMMM yyyy h:mm a"
            }
        ],
        "gateways": [
            {
                "id": "20",
                "name": "Stripe",
                "key": "d14dd26a37cecc30fdd65700bfb55b23",
                "provider": "Stripe",
                "visible": 1,
                "sort_order": 1,
                "site_url": null,
                "is_offsite": false,
                "is_secure": false,
                "fields": "{}",
                "default_gateway_type_id": "1",
                "created_at": 1573630686,
                "updated_at": 1573630686
            }
        ],
        "gateway_types": [
            {
                "id": "1",
                "alias": "credit_card",
                "name": "Credit Card"
            },
            {
                "id": "2",
                "alias": "bank_transfer",
                "name": "Bank Transfer"
            },
            {
                "id": "3",
                "alias": "paypal",
                "name": "PayPal"
            },
            {
                "id": "4",
                "alias": "bitcoin",
                "name": "Bitcoin"
            },
            {
                "id": "5",
                "alias": "dwolla",
                "name": "Dwolla"
            },
            {
                "id": "6",
                "alias": "custom1",
                "name": "Custom"
            },
            {
                "id": "7",
                "alias": "alipay",
                "name": "Alipay"
            },
            {
                "id": "8",
                "alias": "sofort",
                "name": "Sofort"
            },
            {
                "id": "9",
                "alias": "sepa",
                "name": "SEPA"
            },
            {
                "id": "10",
                "alias": "gocardless",
                "name": "GoCardless"
            },
            {
                "id": "11",
                "alias": "apple_pay",
                "name": "Apple Pay"
            },
            {
                "id": "12",
                "alias": "custom2",
                "name": "Custom"
            },
            {
                "id": "13",
                "alias": "custom3",
                "name": "Custom"
            }
        ],
        "industries": [
            {
                "id": "1",
                "name": "Accounting & Legal"
            },
            {
                "id": "2",
                "name": "Advertising"
            },
            {
                "id": "3",
                "name": "Aerospace"
            },
            {
                "id": "4",
                "name": "Agriculture"
            },
            {
                "id": "5",
                "name": "Automotive"
            },
            {
                "id": "6",
                "name": "Banking & Finance"
            },
            {
                "id": "7",
                "name": "Biotechnology"
            },
            {
                "id": "8",
                "name": "Broadcasting"
            },
            {
                "id": "9",
                "name": "Business Services"
            },
            {
                "id": "10",
                "name": "Commodities & Chemicals"
            },
            {
                "id": "11",
                "name": "Communications"
            },
            {
                "id": "12",
                "name": "Computers & Hightech"
            },
            {
                "id": "32",
                "name": "Construction"
            },
            {
                "id": "13",
                "name": "Defense"
            },
            {
                "id": "14",
                "name": "Energy"
            },
            {
                "id": "15",
                "name": "Entertainment"
            },
            {
                "id": "16",
                "name": "Government"
            },
            {
                "id": "17",
                "name": "Healthcare & Life Sciences"
            },
            {
                "id": "18",
                "name": "Insurance"
            },
            {
                "id": "19",
                "name": "Manufacturing"
            },
            {
                "id": "20",
                "name": "Marketing"
            },
            {
                "id": "21",
                "name": "Media"
            },
            {
                "id": "22",
                "name": "Nonprofit & Higher Ed"
            },
            {
                "id": "30",
                "name": "Other"
            },
            {
                "id": "23",
                "name": "Pharmaceuticals"
            },
            {
                "id": "31",
                "name": "Photography"
            },
            {
                "id": "24",
                "name": "Professional Services & Consulting"
            },
            {
                "id": "25",
                "name": "Real Estate"
            },
            {
                "id": "33",
                "name": "Restaurant & Catering"
            },
            {
                "id": "26",
                "name": "Retail & Wholesale"
            },
            {
                "id": "27",
                "name": "Sports"
            },
            {
                "id": "28",
                "name": "Transportation"
            },
            {
                "id": "29",
                "name": "Travel & Luxury"
            }
        ],
        "languages": [
            {
                "id": "18",
                "name": "Albanian",
                "locale": "sq"
            },
            {
                "id": "28",
                "name": "Chinese - Taiwan",
                "locale": "zh_TW"
            },
            {
                "id": "17",
                "name": "Croatian",
                "locale": "hr"
            },
            {
                "id": "16",
                "name": "Czech",
                "locale": "cs"
            },
            {
                "id": "9",
                "name": "Danish",
                "locale": "da"
            },
            {
                "id": "6",
                "name": "Dutch",
                "locale": "nl"
            },
            {
                "id": "1",
                "name": "English",
                "locale": "en"
            },
            {
                "id": "20",
                "name": "English - United Kingdom",
                "locale": "en_GB"
            },
            {
                "id": "23",
                "name": "Finnish",
                "locale": "fi"
            },
            {
                "id": "4",
                "name": "French",
                "locale": "fr"
            },
            {
                "id": "13",
                "name": "French - Canada",
                "locale": "fr_CA"
            },
            {
                "id": "3",
                "name": "German",
                "locale": "de"
            },
            {
                "id": "19",
                "name": "Greek",
                "locale": "el"
            },
            {
                "id": "2",
                "name": "Italian",
                "locale": "it"
            },
            {
                "id": "10",
                "name": "Japanese",
                "locale": "ja"
            },
            {
                "id": "14",
                "name": "Lithuanian",
                "locale": "lt"
            },
            {
                "id": "27",
                "name": "Macedonian",
                "locale": "mk_MK"
            },
            {
                "id": "8",
                "name": "Norwegian",
                "locale": "nb_NO"
            },
            {
                "id": "15",
                "name": "Polish",
                "locale": "pl"
            },
            {
                "id": "5",
                "name": "Portuguese - Brazilian",
                "locale": "pt_BR"
            },
            {
                "id": "21",
                "name": "Portuguese - Portugal",
                "locale": "pt_PT"
            },
            {
                "id": "24",
                "name": "Romanian",
                "locale": "ro"
            },
            {
                "id": "22",
                "name": "Slovenian",
                "locale": "sl"
            },
            {
                "id": "7",
                "name": "Spanish",
                "locale": "es"
            },
            {
                "id": "12",
                "name": "Spanish - Spain",
                "locale": "es_ES"
            },
            {
                "id": "11",
                "name": "Swedish",
                "locale": "sv"
            },
            {
                "id": "26",
                "name": "Thai",
                "locale": "th"
            },
            {
                "id": "25",
                "name": "Turkish - Turkey",
                "locale": "tr_TR"
            }
        ],
        "payment_types": [
            {
                "id": "5",
                "name": "ACH",
                "gateway_type_id": 2
            },
            {
                "id": "28",
                "name": "Alipay",
                "gateway_type_id": 7
            },
            {
                "id": "8",
                "name": "American Express",
                "gateway_type_id": 1
            },
            {
                "id": "1",
                "name": "Apply Credit",
                "gateway_type_id": null
            },
            {
                "id": "2",
                "name": "Bank Transfer",
                "gateway_type_id": 2
            },
            {
                "id": "32",
                "name": "Bitcoin",
                "gateway_type_id": 4
            },
            {
                "id": "17",
                "name": "Carte Blanche",
                "gateway_type_id": 1
            },
            {
                "id": "3",
                "name": "Cash",
                "gateway_type_id": null
            },
            {
                "id": "16",
                "name": "Check",
                "gateway_type_id": null
            },
            {
                "id": "13",
                "name": "Credit Card Other",
                "gateway_type_id": 1
            },
            {
                "id": "4",
                "name": "Debit",
                "gateway_type_id": 1
            },
            {
                "id": "10",
                "name": "Diners Card",
                "gateway_type_id": 1
            },
            {
                "id": "9",
                "name": "Discover Card",
                "gateway_type_id": 1
            },
            {
                "id": "11",
                "name": "EuroCard",
                "gateway_type_id": 1
            },
            {
                "id": "31",
                "name": "GoCardless",
                "gateway_type_id": 10
            },
            {
                "id": "15",
                "name": "Google Wallet",
                "gateway_type_id": null
            },
            {
                "id": "19",
                "name": "JCB",
                "gateway_type_id": 1
            },
            {
                "id": "20",
                "name": "Laser",
                "gateway_type_id": 1
            },
            {
                "id": "21",
                "name": "Maestro",
                "gateway_type_id": 1
            },
            {
                "id": "7",
                "name": "MasterCard",
                "gateway_type_id": 1
            },
            {
                "id": "27",
                "name": "Money Order",
                "gateway_type_id": null
            },
            {
                "id": "12",
                "name": "Nova",
                "gateway_type_id": 1
            },
            {
                "id": "14",
                "name": "PayPal",
                "gateway_type_id": 3
            },
            {
                "id": "30",
                "name": "SEPA Direct Debit",
                "gateway_type_id": 9
            },
            {
                "id": "29",
                "name": "Sofort",
                "gateway_type_id": 8
            },
            {
                "id": "22",
                "name": "Solo",
                "gateway_type_id": 1
            },
            {
                "id": "25",
                "name": "Swish",
                "gateway_type_id": 2
            },
            {
                "id": "23",
                "name": "Switch",
                "gateway_type_id": 1
            },
            {
                "id": "18",
                "name": "UnionPay",
                "gateway_type_id": 1
            },
            {
                "id": "26",
                "name": "Venmo",
                "gateway_type_id": null
            },
            {
                "id": "6",
                "name": "Visa Card",
                "gateway_type_id": 1
            },
            {
                "id": "24",
                "name": "iZettle",
                "gateway_type_id": 1
            }
        ],
        "sizes": [
            {
                "id": "1",
                "name": "1 - 3"
            },
            {
                "id": "2",
                "name": "4 - 10"
            },
            {
                "id": "3",
                "name": "11 - 50"
            },
            {
                "id": "4",
                "name": "51 - 100"
            },
            {
                "id": "5",
                "name": "101 - 500"
            },
            {
                "id": "6",
                "name": "500+"
            }
        ],
        "timezones": [
            {
                "id": "1",
                "name": "Pacific\/Midway",
                "location": "(GMT-11:00) Midway Island",
                "utc_offset": -39600
            },
            {
                "id": "2",
                "name": "US\/Samoa",
                "location": "(GMT-11:00) Samoa",
                "utc_offset": -39600
            },
            {
                "id": "3",
                "name": "US\/Hawaii",
                "location": "(GMT-10:00) Hawaii",
                "utc_offset": -36000
            },
            {
                "id": "4",
                "name": "US\/Alaska",
                "location": "(GMT-09:00) Alaska",
                "utc_offset": -32400
            },
            {
                "id": "5",
                "name": "US\/Pacific",
                "location": "(GMT-08:00) Pacific Time (US &amp; Canada)",
                "utc_offset": -28800
            },
            {
                "id": "6",
                "name": "America\/Tijuana",
                "location": "(GMT-08:00) Tijuana",
                "utc_offset": -28800
            },
            {
                "id": "7",
                "name": "US\/Arizona",
                "location": "(GMT-07:00) Arizona",
                "utc_offset": -25200
            },
            {
                "id": "8",
                "name": "US\/Mountain",
                "location": "(GMT-07:00) Mountain Time (US &amp; Canada)",
                "utc_offset": -25200
            },
            {
                "id": "9",
                "name": "America\/Chihuahua",
                "location": "(GMT-07:00) Chihuahua",
                "utc_offset": -25200
            },
            {
                "id": "10",
                "name": "America\/Mazatlan",
                "location": "(GMT-07:00) Mazatlan",
                "utc_offset": -25200
            },
            {
                "id": "11",
                "name": "America\/Mexico_City",
                "location": "(GMT-06:00) Mexico City",
                "utc_offset": -21600
            },
            {
                "id": "12",
                "name": "America\/Monterrey",
                "location": "(GMT-06:00) Monterrey",
                "utc_offset": -21600
            },
            {
                "id": "13",
                "name": "Canada\/Saskatchewan",
                "location": "(GMT-06:00) Saskatchewan",
                "utc_offset": -21600
            },
            {
                "id": "14",
                "name": "US\/Central",
                "location": "(GMT-06:00) Central Time (US &amp; Canada)",
                "utc_offset": -21600
            },
            {
                "id": "15",
                "name": "US\/Eastern",
                "location": "(GMT-05:00) Eastern Time (US &amp; Canada)",
                "utc_offset": -18000
            },
            {
                "id": "16",
                "name": "US\/East-Indiana",
                "location": "(GMT-05:00) Indiana (East)",
                "utc_offset": -18000
            },
            {
                "id": "17",
                "name": "America\/Bogota",
                "location": "(GMT-05:00) Bogota",
                "utc_offset": -18000
            },
            {
                "id": "18",
                "name": "America\/Lima",
                "location": "(GMT-05:00) Lima",
                "utc_offset": -18000
            },
            {
                "id": "19",
                "name": "America\/Caracas",
                "location": "(GMT-04:00) Caracas",
                "utc_offset": -14400
            },
            {
                "id": "20",
                "name": "Canada\/Atlantic",
                "location": "(GMT-04:00) Atlantic Time (Canada)",
                "utc_offset": -14400
            },
            {
                "id": "21",
                "name": "America\/La_Paz",
                "location": "(GMT-04:00) La Paz",
                "utc_offset": -14400
            },
            {
                "id": "22",
                "name": "America\/Santiago",
                "location": "(GMT-04:00) Santiago",
                "utc_offset": -14400
            },
            {
                "id": "23",
                "name": "Canada\/Newfoundland",
                "location": "(GMT-03:30) Newfoundland",
                "utc_offset": -12600
            },
            {
                "id": "24",
                "name": "America\/Buenos_Aires",
                "location": "(GMT-03:00) Buenos Aires",
                "utc_offset": -10800
            },
            {
                "id": "25",
                "name": "America\/Godthab",
                "location": "(GMT-03:00) Greenland",
                "utc_offset": -10800
            },
            {
                "id": "26",
                "name": "Atlantic\/Stanley",
                "location": "(GMT-02:00) Stanley",
                "utc_offset": -7200
            },
            {
                "id": "27",
                "name": "Atlantic\/Azores",
                "location": "(GMT-01:00) Azores",
                "utc_offset": -3600
            },
            {
                "id": "28",
                "name": "Atlantic\/Cape_Verde",
                "location": "(GMT-01:00) Cape Verde Is.",
                "utc_offset": -3600
            },
            {
                "id": "29",
                "name": "Africa\/Casablanca",
                "location": "(GMT) Casablanca",
                "utc_offset": 0
            },
            {
                "id": "30",
                "name": "Europe\/Dublin",
                "location": "(GMT) Dublin",
                "utc_offset": 0
            },
            {
                "id": "31",
                "name": "Europe\/Lisbon",
                "location": "(GMT) Lisbon",
                "utc_offset": 0
            },
            {
                "id": "32",
                "name": "Europe\/London",
                "location": "(GMT) London",
                "utc_offset": 0
            },
            {
                "id": "33",
                "name": "Africa\/Monrovia",
                "location": "(GMT) Monrovia",
                "utc_offset": 0
            },
            {
                "id": "34",
                "name": "Europe\/Amsterdam",
                "location": "(GMT+01:00) Amsterdam",
                "utc_offset": 3600
            },
            {
                "id": "35",
                "name": "Europe\/Belgrade",
                "location": "(GMT+01:00) Belgrade",
                "utc_offset": 3600
            },
            {
                "id": "36",
                "name": "Europe\/Berlin",
                "location": "(GMT+01:00) Berlin",
                "utc_offset": 3600
            },
            {
                "id": "37",
                "name": "Europe\/Bratislava",
                "location": "(GMT+01:00) Bratislava",
                "utc_offset": 3600
            },
            {
                "id": "38",
                "name": "Europe\/Brussels",
                "location": "(GMT+01:00) Brussels",
                "utc_offset": 3600
            },
            {
                "id": "39",
                "name": "Europe\/Budapest",
                "location": "(GMT+01:00) Budapest",
                "utc_offset": 3600
            },
            {
                "id": "40",
                "name": "Europe\/Copenhagen",
                "location": "(GMT+01:00) Copenhagen",
                "utc_offset": 3600
            },
            {
                "id": "41",
                "name": "Europe\/Ljubljana",
                "location": "(GMT+01:00) Ljubljana",
                "utc_offset": 3600
            },
            {
                "id": "42",
                "name": "Europe\/Madrid",
                "location": "(GMT+01:00) Madrid",
                "utc_offset": 3600
            },
            {
                "id": "43",
                "name": "Europe\/Paris",
                "location": "(GMT+01:00) Paris",
                "utc_offset": 3600
            },
            {
                "id": "44",
                "name": "Europe\/Prague",
                "location": "(GMT+01:00) Prague",
                "utc_offset": 3600
            },
            {
                "id": "45",
                "name": "Europe\/Rome",
                "location": "(GMT+01:00) Rome",
                "utc_offset": 3600
            },
            {
                "id": "46",
                "name": "Europe\/Sarajevo",
                "location": "(GMT+01:00) Sarajevo",
                "utc_offset": 3600
            },
            {
                "id": "47",
                "name": "Europe\/Skopje",
                "location": "(GMT+01:00) Skopje",
                "utc_offset": 3600
            },
            {
                "id": "48",
                "name": "Europe\/Stockholm",
                "location": "(GMT+01:00) Stockholm",
                "utc_offset": 3600
            },
            {
                "id": "49",
                "name": "Europe\/Vienna",
                "location": "(GMT+01:00) Vienna",
                "utc_offset": 3600
            },
            {
                "id": "50",
                "name": "Europe\/Warsaw",
                "location": "(GMT+01:00) Warsaw",
                "utc_offset": 3600
            },
            {
                "id": "51",
                "name": "Europe\/Zagreb",
                "location": "(GMT+01:00) Zagreb",
                "utc_offset": 3600
            },
            {
                "id": "52",
                "name": "Europe\/Athens",
                "location": "(GMT+02:00) Athens",
                "utc_offset": 7200
            },
            {
                "id": "53",
                "name": "Europe\/Bucharest",
                "location": "(GMT+02:00) Bucharest",
                "utc_offset": 7200
            },
            {
                "id": "54",
                "name": "Africa\/Cairo",
                "location": "(GMT+02:00) Cairo",
                "utc_offset": 7200
            },
            {
                "id": "55",
                "name": "Africa\/Harare",
                "location": "(GMT+02:00) Harare",
                "utc_offset": 7200
            },
            {
                "id": "56",
                "name": "Europe\/Helsinki",
                "location": "(GMT+02:00) Helsinki",
                "utc_offset": 7200
            },
            {
                "id": "57",
                "name": "Europe\/Istanbul",
                "location": "(GMT+02:00) Istanbul",
                "utc_offset": 7200
            },
            {
                "id": "58",
                "name": "Asia\/Jerusalem",
                "location": "(GMT+02:00) Jerusalem",
                "utc_offset": 7200
            },
            {
                "id": "59",
                "name": "Europe\/Kiev",
                "location": "(GMT+02:00) Kyiv",
                "utc_offset": 7200
            },
            {
                "id": "60",
                "name": "Europe\/Minsk",
                "location": "(GMT+02:00) Minsk",
                "utc_offset": 7200
            },
            {
                "id": "61",
                "name": "Europe\/Riga",
                "location": "(GMT+02:00) Riga",
                "utc_offset": 7200
            },
            {
                "id": "62",
                "name": "Europe\/Sofia",
                "location": "(GMT+02:00) Sofia",
                "utc_offset": 7200
            },
            {
                "id": "63",
                "name": "Europe\/Tallinn",
                "location": "(GMT+02:00) Tallinn",
                "utc_offset": 7200
            },
            {
                "id": "64",
                "name": "Europe\/Vilnius",
                "location": "(GMT+02:00) Vilnius",
                "utc_offset": 7200
            },
            {
                "id": "65",
                "name": "Asia\/Baghdad",
                "location": "(GMT+03:00) Baghdad",
                "utc_offset": 10800
            },
            {
                "id": "66",
                "name": "Asia\/Kuwait",
                "location": "(GMT+03:00) Kuwait",
                "utc_offset": 10800
            },
            {
                "id": "67",
                "name": "Africa\/Nairobi",
                "location": "(GMT+03:00) Nairobi",
                "utc_offset": 10800
            },
            {
                "id": "68",
                "name": "Asia\/Riyadh",
                "location": "(GMT+03:00) Riyadh",
                "utc_offset": 10800
            },
            {
                "id": "69",
                "name": "Asia\/Tehran",
                "location": "(GMT+03:30) Tehran",
                "utc_offset": 12600
            },
            {
                "id": "70",
                "name": "Europe\/Moscow",
                "location": "(GMT+04:00) Moscow",
                "utc_offset": 14400
            },
            {
                "id": "71",
                "name": "Asia\/Baku",
                "location": "(GMT+04:00) Baku",
                "utc_offset": 14400
            },
            {
                "id": "72",
                "name": "Europe\/Volgograd",
                "location": "(GMT+04:00) Volgograd",
                "utc_offset": 14400
            },
            {
                "id": "73",
                "name": "Asia\/Muscat",
                "location": "(GMT+04:00) Muscat",
                "utc_offset": 14400
            },
            {
                "id": "74",
                "name": "Asia\/Tbilisi",
                "location": "(GMT+04:00) Tbilisi",
                "utc_offset": 14400
            },
            {
                "id": "75",
                "name": "Asia\/Yerevan",
                "location": "(GMT+04:00) Yerevan",
                "utc_offset": 14400
            },
            {
                "id": "76",
                "name": "Asia\/Kabul",
                "location": "(GMT+04:30) Kabul",
                "utc_offset": 16200
            },
            {
                "id": "77",
                "name": "Asia\/Karachi",
                "location": "(GMT+05:00) Karachi",
                "utc_offset": 18000
            },
            {
                "id": "78",
                "name": "Asia\/Tashkent",
                "location": "(GMT+05:00) Tashkent",
                "utc_offset": 18000
            },
            {
                "id": "79",
                "name": "Asia\/Kolkata",
                "location": "(GMT+05:30) Kolkata",
                "utc_offset": 19800
            },
            {
                "id": "80",
                "name": "Asia\/Kathmandu",
                "location": "(GMT+05:45) Kathmandu",
                "utc_offset": 20700
            },
            {
                "id": "81",
                "name": "Asia\/Yekaterinburg",
                "location": "(GMT+06:00) Ekaterinburg",
                "utc_offset": 21600
            },
            {
                "id": "82",
                "name": "Asia\/Almaty",
                "location": "(GMT+06:00) Almaty",
                "utc_offset": 21600
            },
            {
                "id": "83",
                "name": "Asia\/Dhaka",
                "location": "(GMT+06:00) Dhaka",
                "utc_offset": 21600
            },
            {
                "id": "84",
                "name": "Asia\/Novosibirsk",
                "location": "(GMT+07:00) Novosibirsk",
                "utc_offset": 25200
            },
            {
                "id": "85",
                "name": "Asia\/Bangkok",
                "location": "(GMT+07:00) Bangkok",
                "utc_offset": 25200
            },
            {
                "id": "86",
                "name": "Asia\/Ho_Chi_Minh",
                "location": "(GMT+07.00) Ho Chi Minh",
                "utc_offset": 25200
            },
            {
                "id": "87",
                "name": "Asia\/Jakarta",
                "location": "(GMT+07:00) Jakarta",
                "utc_offset": 25200
            },
            {
                "id": "88",
                "name": "Asia\/Krasnoyarsk",
                "location": "(GMT+08:00) Krasnoyarsk",
                "utc_offset": 28800
            },
            {
                "id": "89",
                "name": "Asia\/Chongqing",
                "location": "(GMT+08:00) Chongqing",
                "utc_offset": 28800
            },
            {
                "id": "90",
                "name": "Asia\/Hong_Kong",
                "location": "(GMT+08:00) Hong Kong",
                "utc_offset": 28800
            },
            {
                "id": "91",
                "name": "Asia\/Kuala_Lumpur",
                "location": "(GMT+08:00) Kuala Lumpur",
                "utc_offset": 28800
            },
            {
                "id": "92",
                "name": "Australia\/Perth",
                "location": "(GMT+08:00) Perth",
                "utc_offset": 28800
            },
            {
                "id": "93",
                "name": "Asia\/Singapore",
                "location": "(GMT+08:00) Singapore",
                "utc_offset": 28800
            },
            {
                "id": "94",
                "name": "Asia\/Taipei",
                "location": "(GMT+08:00) Taipei",
                "utc_offset": 28800
            },
            {
                "id": "95",
                "name": "Asia\/Ulaanbaatar",
                "location": "(GMT+08:00) Ulaan Bataar",
                "utc_offset": 28800
            },
            {
                "id": "96",
                "name": "Asia\/Urumqi",
                "location": "(GMT+08:00) Urumqi",
                "utc_offset": 28800
            },
            {
                "id": "97",
                "name": "Asia\/Irkutsk",
                "location": "(GMT+09:00) Irkutsk",
                "utc_offset": 32400
            },
            {
                "id": "98",
                "name": "Asia\/Seoul",
                "location": "(GMT+09:00) Seoul",
                "utc_offset": 32400
            },
            {
                "id": "99",
                "name": "Asia\/Tokyo",
                "location": "(GMT+09:00) Tokyo",
                "utc_offset": 32400
            },
            {
                "id": "100",
                "name": "Australia\/Adelaide",
                "location": "(GMT+09:30) Adelaide",
                "utc_offset": 34200
            },
            {
                "id": "101",
                "name": "Australia\/Darwin",
                "location": "(GMT+09:30) Darwin",
                "utc_offset": 34200
            },
            {
                "id": "102",
                "name": "Asia\/Yakutsk",
                "location": "(GMT+10:00) Yakutsk",
                "utc_offset": 36000
            },
            {
                "id": "103",
                "name": "Australia\/Brisbane",
                "location": "(GMT+10:00) Brisbane",
                "utc_offset": 36000
            },
            {
                "id": "104",
                "name": "Australia\/Canberra",
                "location": "(GMT+10:00) Canberra",
                "utc_offset": 36000
            },
            {
                "id": "105",
                "name": "Pacific\/Guam",
                "location": "(GMT+10:00) Guam",
                "utc_offset": 36000
            },
            {
                "id": "106",
                "name": "Australia\/Hobart",
                "location": "(GMT+10:00) Hobart",
                "utc_offset": 36000
            },
            {
                "id": "107",
                "name": "Australia\/Melbourne",
                "location": "(GMT+10:00) Melbourne",
                "utc_offset": 36000
            },
            {
                "id": "108",
                "name": "Pacific\/Port_Moresby",
                "location": "(GMT+10:00) Port Moresby",
                "utc_offset": 36000
            },
            {
                "id": "109",
                "name": "Australia\/Sydney",
                "location": "(GMT+10:00) Sydney",
                "utc_offset": 36000
            },
            {
                "id": "110",
                "name": "Asia\/Vladivostok",
                "location": "(GMT+11:00) Vladivostok",
                "utc_offset": 39600
            },
            {
                "id": "111",
                "name": "Asia\/Magadan",
                "location": "(GMT+12:00) Magadan",
                "utc_offset": 43200
            },
            {
                "id": "112",
                "name": "Pacific\/Auckland",
                "location": "(GMT+12:00) Auckland",
                "utc_offset": 43200
            },
            {
                "id": "113",
                "name": "Pacific\/Fiji",
                "location": "(GMT+12:00) Fiji",
                "utc_offset": 43200
            }
        ]
    }
}
''';