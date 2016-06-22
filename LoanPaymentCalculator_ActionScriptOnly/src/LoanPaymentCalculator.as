package
{
	import flash.events.Event;

	public class LoanPaymentCalculator
	{
		public function LoanPaymentCalculator()
		{
			var calculatorForm:HTMLFormElement = document.createElement("form") as HTMLFormElement;
			document.body.appendChild(calculatorForm);

			var title:HTMLHeadingElement = document.createElement("h1") as HTMLHeadingElement;
			title.textContent = "Loan Payment Calculator";
			calculatorForm.appendChild(title);

			var principalLabel:HTMLLabelElement = document.createElement("label") as HTMLLabelElement;
			principalLabel.htmlFor = "principal-input";
			principalLabel.textContent = "Principal";
			principalLabel.style.display = "block";
			calculatorForm.appendChild(principalLabel);
			this._principalInput = document.createElement("input") as HTMLInputElement;
			this._principalInput.id = "principal-input";
			this._principalInput.type = "number";
			this._principalInput.value = "200000";
			this._principalInput.step = "1000";
			calculatorForm.appendChild(this._principalInput);

			var interestLabel:HTMLLabelElement = document.createElement("label") as HTMLLabelElement;
			interestLabel.htmlFor = "interest-input";
			interestLabel.textContent = "Interest";
			interestLabel.style.display = "block";
			calculatorForm.appendChild(interestLabel);
			this._interestInput = document.createElement("input") as HTMLInputElement;
			this._interestInput.id = "interest-input";
			this._interestInput.type = "number";
			this._interestInput.value = "6";
			this._interestInput.step = "0.1";
			calculatorForm.appendChild(this._interestInput);

			var yearsLabel:HTMLLabelElement = document.createElement("label") as HTMLLabelElement;
			yearsLabel.htmlFor = "years-input";
			yearsLabel.textContent = "Years";
			yearsLabel.style.display = "block";
			calculatorForm.appendChild(yearsLabel);
			this._yearsInput = document.createElement("input") as HTMLInputElement;
			this._yearsInput.id = "years-input";
			this._yearsInput.type = "number";
			this._yearsInput.value = "15";
			this._yearsInput.step = "5";
			this._yearsInput.min = "10";
			this._yearsInput.max = "50";
			calculatorForm.appendChild(this._yearsInput);

			var paymentMessage:HTMLParagraphElement = document.createElement("p") as HTMLParagraphElement;
			paymentMessage.textContent = "Payment: ";
			this._paymentResultSpan = document.createElement("span") as HTMLSpanElement;
			this._paymentResultSpan.id = "result-text";
			this._paymentResultSpan.textContent = "1687.71";
			paymentMessage.appendChild(this._paymentResultSpan);
			paymentMessage.appendChild(document.createTextNode(" per month"));
			calculatorForm.appendChild(paymentMessage);

			var submitButton:HTMLButtonElement = document.createElement("button") as HTMLButtonElement;
			submitButton.textContent = "Calculate New Payment";
			calculatorForm.appendChild(submitButton);

			calculatorForm.addEventListener("submit", form_submitHandler, false);
		}

		private var _principalInput:HTMLInputElement;
		private var _interestInput:HTMLInputElement;
		private var _yearsInput:HTMLInputElement;
		private var _paymentResultSpan:HTMLSpanElement;

		private function calculatePayment(principal:Number, interestRate:Number, years:int):Number
		{
			var effectiveInterestRate:Number = (interestRate / 100) / 12;
			var totalPaymentCount:int = years * 12;
			return principal * (effectiveInterestRate / (1 - Math.pow(1 + effectiveInterestRate, -totalPaymentCount)))
		}

		private function form_submitHandler(event:Event):void
		{
			event.preventDefault();

			var principal:Number = parseFloat(this._principalInput.value);
			var interestRate:Number = parseFloat(this._interestInput.value);
			var years:int = parseInt(this._yearsInput.value, 10);
			var payment:Number = calculatePayment(principal, interestRate, years);
			this._paymentResultSpan.innerHTML = payment.toFixed(2);
		}
	}
}
